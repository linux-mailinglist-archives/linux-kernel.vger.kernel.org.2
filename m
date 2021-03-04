Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965C632D4D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhCDOFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237018AbhCDOEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614866603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWRYY4xlDMGx9O1TM1bjsWJ7KLbEpS60XIQVZBaQhok=;
        b=F/BWCuN7e4bL7ISZY8Clor0KPyOD3VQolbpvxwaIVfWFDXIoeHB/foQF/CJEfTGOZYeg8T
        7WfNPorIUkNccfKRK79k97L0FEkII537L1T97WDrEPFfCRSpSK+Y4ch6VMZZaKT4IrZLf7
        TB4vcvV2gaF/8HdZDBV9nc1IL55wvlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-wt3m-SyAP6-dodfRZhHdAA-1; Thu, 04 Mar 2021 09:03:21 -0500
X-MC-Unique: wt3m-SyAP6-dodfRZhHdAA-1
Received: by mail-wm1-f69.google.com with SMTP id w20so2769866wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWRYY4xlDMGx9O1TM1bjsWJ7KLbEpS60XIQVZBaQhok=;
        b=iRXHzGUv6cFnMOGBRNCxJNNj290aTFymhwbF5EP4faMDFa3rDB0kTdo/Q2uUZQtwBB
         Rt0jXsBdkyU3PHV7U8icA1ZHhKPYF9JrM0PCowzWbOaDSUE8UOpFDWO8TyMj6D1uEpjb
         2QKQhff0pmz4Nt56EvhAVFr8dwDrma5/2kxaknCx46m0bcTjmnOmSVSXMa0w3V4fMyF0
         J9VGClBvKrTg36T3jZEdLEBP//6O/gXx9Y56VUkzvCKW5eBKI9mGkG/Ob0pLOaWko2+c
         8p/GMPkzR0ZMwIhHVzTTgZ/SElYxjMAxlkE8eJsQe8NhBfVeoJll4m8I6qzYfia73Tuw
         uhjA==
X-Gm-Message-State: AOAM530c2WRFEQeAXCBkOyAcJuEs+avJK6GyN1Xq+eM3f2wdBnX3MFRI
        cMqmkXHYR3SZH6AK3pbGiHm6KirBj32LLCOqIK2U+IEbkg5AFUaKYVamldNCtKaINoRdqngQm7u
        Qiqx6G+Pz9XRNZtRSHPOB1kw7
X-Received: by 2002:a1c:6707:: with SMTP id b7mr4250425wmc.185.1614866596077;
        Thu, 04 Mar 2021 06:03:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0FwkNv8hcTiGGNQD1zTXrnjWvlYY15HzXLNp58FcVU0HFnrPJqOYCVqAg7HUW5xd52n0npA==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr4249949wmc.185.1614866591451;
        Thu, 04 Mar 2021 06:03:11 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm5945759wmq.16.2021.03.04.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 06:03:10 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        ycote@redhat.com, Julien Thierry <jthierry@redhat.com>
Subject: Re: [RFC PATCH v2 00/13] objtool: add base support for arm64
Date:   Thu,  4 Mar 2021 15:03:08 +0100
Message-Id: <20210304140308.1891245-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <YD/g2G3Yi8o99f7H@hirez.programming.kicks-ass.net>
References: <YD/g2G3Yi8o99f7H@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/21 8:17 PM, Peter Zijlstra wrote:
> One selfish thing, would it make sense to have a make target that builds
> all supported srcarch targets?
>
> This might be useful when hacking on objtool to make sure everything
> builds.
>

That makes sense. I can offer something like bellow which is simple
enough to use and update.

Otherwise you could have per arch targets, but since the generic part of
objtool uses arch specific headers, you'll have to rebuild object files
between two arch builds anyway.

Julien

-->

From 36cf9e05f2ee40bd5239c3b78cd1c5260941cb94 Mon Sep 17 00:00:00 2001
Date: Thu, 4 Mar 2021 14:46:39 +0100
Subject: [PATCH] objtool: Add target to test build of different architectures

To make sure support for other architecture doesn't break when updating
objtool, it's useful to have a shorthand to build the different objtool
configuration.

Add a target that can be called from the top level as such:

    $ make tools/objtool/build-test

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/Makefile         | 3 +++
 tools/objtool/Makefile | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index 7e9d34ddd74c..79e4a5ff0576 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -68,6 +68,9 @@ cpupower: FORCE
 cgroup firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
 	$(call descend,$@)

+objtool/%: FORCE
+	$(call descend,objtool,$@)
+
 bpf/%: FORCE
 	$(call descend,$@)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index d5cfbec87c02..4c57f8cdaeb6 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -56,6 +56,12 @@ export SUBCMD_CHECK SUBCMD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include

+objtool/build-test: FORCE
+	@SRCARCH=x86 $(MAKE)
+	@SRCARCH=x86 $(MAKE) clean
+	@SRCARCH=arm64 $(MAKE)
+	@SRCARCH=arm64 $(MAKE) clean
+
 $(OBJTOOL_IN): fixdep FORCE
 	@$(CONFIG_SHELL) ./sync-check.sh
 	@$(MAKE) $(build)=objtool
--
2.25.4

