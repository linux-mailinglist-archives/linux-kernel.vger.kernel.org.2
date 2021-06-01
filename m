Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF439771F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhFAPuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhFAPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:49:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EE6C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:48:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z8so9752001wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wEwX9WZesArWKsstP4MgeMs+pB7+trRKG9aUiLAejfI=;
        b=j7funsS3lgOohm05QYVU+t8GGWwgu0Wf20fsocDj/LBWHAlMAMRLryyp9qyZQdrJzs
         19JU1dDbayAu7X9IC/gXiuse+1XBdQMfra6E8X8im1Yf2OuhFVB2afWXKUoinPmFOOsT
         WPj3A3VI2jJ9+9fQQNj9JN6DPMCpDDlgMtYnZFDqsVHiJGEBq/t0E30gB5368QBOEng3
         t09QPgcYsVUjhowSdXx8Ng0XLom4WcaVit5zzpCJYbZ9aVUisMW4KnUnndLFhcGfPzsj
         4BhVindCVW1K6mhnWo+HBMMbmTXdM22cbOPjRiJqXlAQK73xamnHyuk/u/yMHQtVVMUS
         IC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wEwX9WZesArWKsstP4MgeMs+pB7+trRKG9aUiLAejfI=;
        b=XdqwTnP69nmJsfQSNeU7vph1jhvPaI2XXWv2ovKNOOrjqChXntebbZShd7d6VKjLCl
         a5jaJUKt4kJB/IjcgRuAdr5uvZFfsXRsRW1AGd4NTDbk10AqLUm3R/q2U2wUuMXq9A28
         b7fyCMt7+/UrKk3jmiBxkZm1FV6kHidmnUHkImoyNuRhT6IrLA5H1JzldmFnIFnzK+fK
         iKnABQ7yQkGQUt//SZXuNxh8kJ25WKatvh97g/DD521VrDYUs8tc7kaFZ5ZPqi6hQdMz
         FG87CFw7QWMXo6bQvBlw/LZ7XFYXIVHLlTHuoiYWhgE5ZKqYZ8QzSqL7r0vq/Za5H8aU
         o4yA==
X-Gm-Message-State: AOAM533mlualqFoQdLF7XNTNzeKmA53K40cclRMUpBFgmtPNSgSbPFnb
        zMWGYoveCzGtRFNLRH/ILKokjA==
X-Google-Smtp-Source: ABdhPJypLSgdyQrzYGtYN1BysUUWmR3te0VbHpPr02pGuGIYnfWllUWNT85DgCvXAJ1Jr1mor+fMhQ==
X-Received: by 2002:a5d:50c1:: with SMTP id f1mr29105131wrt.168.1622562489528;
        Tue, 01 Jun 2021 08:48:09 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id b15sm3342934wru.64.2021.06.01.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:48:08 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:48:06 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     will@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] KVM: arm64: Remove list_head from hyp_page
Message-ID: <YLZWtnGVQSguI1P6@google.com>
References: <20210527125134.2116404-1-qperret@google.com>
 <20210527125134.2116404-4-qperret@google.com>
 <87k0nd1wgx.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0nd1wgx.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 Jun 2021 at 15:38:22 (+0100), Marc Zyngier wrote:
> On Thu, 27 May 2021 13:51:30 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > +/*
> > + * Pages that are available for allocation are tracked in free-lists, so we use
> > + * the pages themselves to store the list nodes to avoid wasting space. As the
> > + * allocator always returns zeroed pages (which are zeroed on the hyp_put_page()
> > + * path to optimize allocation speed), we also need to clean-up the list node in
> > + * each page when we take it out of the list.
> > + */
> > +static inline void page_remove_from_list(struct hyp_page *p)
> > +{
> > +	struct list_head *node = (struct list_head *)hyp_page_to_virt(p);
> 
> Nit: How about changing hyp_page_to_virt() so that it returns a
> convenient 'void *', and get rid of the ugly casts?

It should already return void *, but I kind of liked the explicit cast
here for documentation purpose. We're turning a 'random' piece of unused
memory into a typed object, so that felt like a useful annotation. Happy
to get rid of it though.

> > +
> > +	__list_del_entry(node);
> > +	memset(node, 0, sizeof(*node));
> > +}
> > +
> > +static inline void page_add_to_list(struct hyp_page *p, struct list_head *head)
> > +{
> > +	struct list_head *node = (struct list_head *)hyp_page_to_virt(p);
> > +
> > +	INIT_LIST_HEAD(node);
> > +	list_add_tail(node, head);
> > +}
> > +
> > +static inline struct hyp_page *node_to_page(struct list_head *node)
> > +{
> > +	return (struct hyp_page *)hyp_virt_to_page(node);
> 
> Why is this cast necessary? If I'm not mistaken, hyp_vmemmap is
> already cast as a 'struct hyp_page *', so hyp_virt_to_page() should
> return the same type.

Right, that one is totally unnecessary, I'll remove.

Cheers,
Quentin
