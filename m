Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E043A3D1E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhGVGJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:09:14 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:34795
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230152AbhGVGJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=fCg1zJUymUzvnE4en0dJIKMhmqLZIV8SNjYU
        JQOnRrU=; b=x7aOafxqXZ3rEES2R/MTmKWHtsYMxmIp2wFPT3HQpu98I0mLRmWh
        62JHaceUJOM4lww4ARFmNi1B8ogfDzC2lAY98UFG5uHqfrbbeEntJVejwU5jhP9A
        ePOw0Uc6oIuGLg2ol4bn+HV+/up8lBHGX65mxzUEguOSOvHhIMkEXFg=
Received: by ajax-webmail-app1 (Coremail) ; Thu, 22 Jul 2021 14:49:37 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.86.133]
Date:   Thu, 22 Jul 2021 14:49:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Xiyu Yang" <19210240158@fudan.edu.cn>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Tejun Heo" <tj@kernel.org>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, "Xin Tan" <tanxin.ctf@gmail.com>
Subject: Re: Re: [PATCH] kernfs: Convert from atomic_t to refcount_t on
 kernfs_node->count
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20200917(8294e55f) Copyright (c) 2002-2021 www.mailtech.cn fudan.edu.cn
In-Reply-To: <YPkQ8M9CLqeBvN2W@kroah.com>
References: <60f8506d.1c69fb81.d8d4d.3bceSMTPIN_ADDED_BROKEN@mx.google.com>
 <YPkHAX1YdmxZtW49@kroah.com>
 <350c2c44.5a22.17acce3c8f4.Coremail.19210240158@fudan.edu.cn>
 <YPkQ8M9CLqeBvN2W@kroah.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: 7bit
X-CM-CTRLDATA: d3+xvGZvb3Rlcl90eHQ9Mzc0NToxMA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <57e48621.5aed.17accfa0d36.Coremail.19210240158@fudan.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: XAUFCgDnCZ4BFflg9FumAA--.15883W
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/1tbiAQ8KAVKp4xXwUgACso
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I consider it as a reference count due to its related operations and the developer's comments, such as "put a reference count on a kernfs_node" around the kernfs_put(). If anything wrong, please let me know.

Thanks.

> -----Original Messages-----
> From: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> Sent Time: 2021-07-21 23:36:20 (Wednesday)
> To: "Xiyu Yang" <xiyuyang19@fudan.edu.cn>
> Cc: "Tejun Heo" <tj@kernel.org>, linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, "Xin Tan" <tanxin.ctf@gmail.com>
> Subject: Re: [PATCH] kernfs: Convert from atomic_t to refcount_t on kernfs_node->count
> 
> On Mon, Jul 19, 2021 at 04:33:21PM +0800, Xiyu Yang wrote:
> > refcount_t type and corresponding API can protect refcounters from
> > accidental underflow and overflow and further use-after-free situations.
> 
> But this really is a count, not a refcount.
> 
> So are you _sure_ this should be changed?
> 
> What did you to do to test this?
> 
> thanks,
> 
> greg k-h
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> > ---
> >  fs/kernfs/dir.c        | 12 ++++++------
> >  include/linux/kernfs.h |  3 ++-
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 33166ec90a11..201091e2f2dc 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -491,8 +491,8 @@ static void kernfs_drain(struct kernfs_node *kn)
> >  void kernfs_get(struct kernfs_node *kn)
> >  {
> >  	if (kn) {
> > -		WARN_ON(!atomic_read(&kn->count));
> > -		atomic_inc(&kn->count);
> > +		WARN_ON(!refcount_read(&kn->count));
> > +		refcount_inc(&kn->count);
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(kernfs_get);
> > @@ -508,7 +508,7 @@ void kernfs_put(struct kernfs_node *kn)
> >  	struct kernfs_node *parent;
> >  	struct kernfs_root *root;
> >  
> > -	if (!kn || !atomic_dec_and_test(&kn->count))
> > +	if (!kn || !refcount_dec_and_test(&kn->count))
> >  		return;
> >  	root = kernfs_root(kn);
> >   repeat:
> > @@ -538,7 +538,7 @@ void kernfs_put(struct kernfs_node *kn)
> >  
> >  	kn = parent;
> >  	if (kn) {
> > -		if (atomic_dec_and_test(&kn->count))
> > +		if (refcount_dec_and_test(&kn->count))
> >  			goto repeat;
> >  	} else {
> >  		/* just released the root kn, free @root too */
> > @@ -598,7 +598,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> >  
> >  	kn->id = (u64)id_highbits << 32 | ret;
> >  
> > -	atomic_set(&kn->count, 1);
> > +	refcount_set(&kn->count, 1);
> >  	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
> >  	RB_CLEAR_NODE(&kn->rb);
> >  
> > @@ -691,7 +691,7 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
> >  	 * grab kernfs_mutex.
> >  	 */
> >  	if (unlikely(!(kn->flags & KERNFS_ACTIVATED) ||
> > -		     !atomic_inc_not_zero(&kn->count)))
> > +		     !refcount_inc_not_zero(&kn->count)))
> >  		goto err_unlock;
> >  
> >  	spin_unlock(&kernfs_idr_lock);
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index 9e8ca8743c26..4378a5befcf7 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -6,6 +6,7 @@
> >  #ifndef __LINUX_KERNFS_H
> >  #define __LINUX_KERNFS_H
> >  
> > +#include <linux/refcount.h>
> >  #include <linux/kernel.h>
> >  #include <linux/err.h>
> >  #include <linux/list.h>
> > @@ -121,7 +122,7 @@ struct kernfs_elem_attr {
> >   * active reference.
> >   */
> >  struct kernfs_node {
> > -	atomic_t		count;
> > +	refcount_t		count;
> >  	atomic_t		active;
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >  	struct lockdep_map	dep_map;
> > -- 
> > 2.7.4







