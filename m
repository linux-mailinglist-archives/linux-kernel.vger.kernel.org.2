Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5E8355161
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245252AbhDFK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:58:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245237AbhDFK6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:58:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BEFFAB14C;
        Tue,  6 Apr 2021 10:57:55 +0000 (UTC)
To:     Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     glittao@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210331085156.5028-1-glittao@gmail.com>
 <YGWPdFywfNUl4d3S@elver.google.com>
 <CAGS_qxpWtNLJ7_i5pDYhiGq_Jy+oPPc+HpWjNTJKAPyvQf+gsQ@mail.gmail.com>
 <CANpmjNPhWUsQrG62Z2jchdqzgSOfVYOsD1QDJpRghJwzwRZcQA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 1/2] kunit: add a KUnit test for SLUB debugging
 functionality
Message-ID: <11886d4f-8826-0cd6-b5fd-defc65470ed5@suse.cz>
Date:   Tue, 6 Apr 2021 12:57:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNPhWUsQrG62Z2jchdqzgSOfVYOsD1QDJpRghJwzwRZcQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/21 11:24 PM, Marco Elver wrote:
> On Thu, 1 Apr 2021 at 21:04, Daniel Latypov <dlatypov@google.com> wrote:
>> >         }
>> >         #else
>> >         static inline bool slab_add_kunit_errors(void) { return false; }
>> >         #endif
>> >
>> > And anywhere you want to increase the error count, you'd call
>> > slab_add_kunit_errors().
>> >
>> > Another benefit of this approach is that if KUnit is disabled, there is
>> > zero overhead and no additional code generated (vs. the current
>> > approach).
>>
>> The resource approach looks really good, but...
>> You'd be picking up a dependency on
>> https://lore.kernel.org/linux-kselftest/20210311152314.3814916-2-dlatypov@google.com/
>> current->kunit_test will always be NULL unless CONFIG_KASAN=y &&
>> CONFIG_KUNIT=y at the moment.
>> My patch drops the CONFIG_KASAN requirement and opens it up to all tests.
> 
> Oh, that's a shame, but hopefully it'll be in -next soon.
> 
>> At the moment, it's just waiting another look over from Brendan or David.
>> Any ETA on that, folks? :)
>>
>> So if you don't want to get blocked on that for now, I think it's fine to add:
>>   #ifdef CONFIG_SLUB_KUNIT_TEST
>>   int errors;
>>   #endif
> 
> Until kunit fixes setting current->kunit_test, a cleaner workaround
> that would allow to do the patch with kunit_resource, is to just have
> an .init/.exit function that sets it ("current->kunit_test = test;").
> And then perhaps add a note ("FIXME: ...") to remove it once the above
> patch has landed.
> 
> At least that way we get the least intrusive change for mm/slub.c, and
> the test is the only thing that needs a 2-line patch to clean up
> later.

So when testing internally Oliver's new version with your suggestions (thanks
again for those), I got lockdep splats because slab_add_kunit_errors is called
also from irq disabled contexts, and kunit_find_named_resource will call
spin_lock(&test->lock) that's not irq safe. Can we make the lock irq safe? I
tried the change below and it makde the problem go away. If you agree, the
question is how to proceed - make it part of Oliver's patch series and let
Andrew pick it all with eventually kunit team's acks on this patch, or whatnot.

----8<----

commit ab28505477892e9824c57ac338c88aec2ec0abce
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Tue Apr 6 12:28:07 2021 +0200

    kunit: make test->lock irq safe

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49601c4b98b8..524d4789af22 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -515,8 +515,9 @@ kunit_find_resource(struct kunit *test,
 		    void *match_data)
 {
 	struct kunit_resource *res, *found = NULL;
+	unsigned long flags;
 
-	spin_lock(&test->lock);
+	spin_lock_irqsave(&test->lock, flags);
 
 	list_for_each_entry_reverse(res, &test->resources, node) {
 		if (match(test, res, (void *)match_data)) {
@@ -526,7 +527,7 @@ kunit_find_resource(struct kunit *test,
 		}
 	}
 
-	spin_unlock(&test->lock);
+	spin_unlock_irqrestore(&test->lock, flags);
 
 	return found;
 }
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ec9494e914ef..2c62eeb45b82 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -442,6 +442,7 @@ int kunit_add_resource(struct kunit *test,
 		       void *data)
 {
 	int ret = 0;
+	unsigned long flags;
 
 	res->free = free;
 	kref_init(&res->refcount);
@@ -454,10 +455,10 @@ int kunit_add_resource(struct kunit *test,
 		res->data = data;
 	}
 
-	spin_lock(&test->lock);
+	spin_lock_irqsave(&test->lock, flags);
 	list_add_tail(&res->node, &test->resources);
 	/* refcount for list is established by kref_init() */
-	spin_unlock(&test->lock);
+	spin_unlock_irqrestore(&test->lock, flags);
 
 	return ret;
 }
@@ -515,9 +516,11 @@ EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
 {
-	spin_lock(&test->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
 	list_del(&res->node);
-	spin_unlock(&test->lock);
+	spin_unlock_irqrestore(&test->lock, flags);
 	kunit_put_resource(res);
 }
 EXPORT_SYMBOL_GPL(kunit_remove_resource);
@@ -597,6 +600,7 @@ EXPORT_SYMBOL_GPL(kunit_kfree);
 void kunit_cleanup(struct kunit *test)
 {
 	struct kunit_resource *res;
+	unsigned long flags;
 
 	/*
 	 * test->resources is a stack - each allocation must be freed in the
@@ -608,9 +612,9 @@ void kunit_cleanup(struct kunit *test)
 	 * protect against the current node being deleted, not the next.
 	 */
 	while (true) {
-		spin_lock(&test->lock);
+		spin_lock_irqsave(&test->lock, flags);
 		if (list_empty(&test->resources)) {
-			spin_unlock(&test->lock);
+			spin_unlock_irqrestore(&test->lock, flags);
 			break;
 		}
 		res = list_last_entry(&test->resources,
@@ -621,7 +625,7 @@ void kunit_cleanup(struct kunit *test)
 		 * resource, and this can't happen if the test->lock
 		 * is held.
 		 */
-		spin_unlock(&test->lock);
+		spin_unlock_irqrestore(&test->lock, flags);
 		kunit_remove_resource(test, res);
 	}
 #if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
