Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFA434EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJTPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJTPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634743040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVDnHFlJ2OJw3aNNq/iBi8HOeMjivlQd7nb/i1bB5F8=;
        b=NazmM3D+nkVHeG7Meu4ZcYB34qged3IhORN/UQNsiLqVdBXjvfnLgTI2plFAhvtQNaTe4x
        IGY6rsKui0bz7bF674atr11N0CMtDCAO9CwUdaUlGUNgSykiwEWmF+0NyHUK390NsyC/1j
        lVi+365TkxCygdWOJN8P42PaYXrpj9w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-NuWivmghMG-fQkPo-di0dw-1; Wed, 20 Oct 2021 11:17:19 -0400
X-MC-Unique: NuWivmghMG-fQkPo-di0dw-1
Received: by mail-qk1-f199.google.com with SMTP id z29-20020a05620a08dd00b0045fa369b83dso2399347qkz.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVDnHFlJ2OJw3aNNq/iBi8HOeMjivlQd7nb/i1bB5F8=;
        b=1fKZS64wnehQV7l4fy3pSHZLxuA0yk5P3j7uSGj+vmSuAjUzqta2gZzCOPwFsftJB8
         xnb9PmBu/KFTWLQMSth9aenxT2vy0C1zZe96+xPUr+UYITS5FTj2HgOElCKbC85Y1xQ6
         flQAIk/mp/+jI3XehIPUZa2xvbUBHMpNEe4fIAnAkxY0xven8Bz8Sm0H4PuZLx/5QYbV
         pXl3COHuhP8ZwahZtZjWWwuv0aDklBx/XScQvXfFaTEdQhRDeOyGki+PBNxOWFgcHYUW
         G6RdIzy9x2NPoKwm3JbodQR6DJw2qeELyXmwrmyQwzv68mGzLb/PQ6Aie50duL1BHtvv
         mvfg==
X-Gm-Message-State: AOAM5329+qX/n4un4JFGQUtqrkf7RwB0tpb2Cx5h9dyk/aOPi6tABl1f
        HxFqBI6c74YUjRKUaGJlFp/XfagHsVhaoc+gDtKEjNwY7Bv+pvJj2IBkIbNNz0ZGpdFnN0tXLMv
        vBEWZ5g1GTgqygl4CuUUsKXR3
X-Received: by 2002:a0c:f806:: with SMTP id r6mr219125qvn.49.1634743038545;
        Wed, 20 Oct 2021 08:17:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymXUJtrjprkh5Udlt/BViwvnxtfBQ/fDo80Z3O7jVr0qw/ABwJz2IkE7oHjL4YspAzMzmQYA==
X-Received: by 2002:a0c:f806:: with SMTP id r6mr219093qvn.49.1634743038289;
        Wed, 20 Oct 2021 08:17:18 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h125sm1123214qkc.29.2021.10.20.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 08:17:17 -0700 (PDT)
Date:   Wed, 20 Oct 2021 08:17:14 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 01/14] objtool: Tag retpoline thunk symbols
Message-ID: <20211020151714.sf3wq4d7wuya5jbj@treble>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.557458476@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020105842.557458476@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:43PM +0200, Peter Zijlstra wrote:
> In order to avoid calling arch_is_retpoline() (which does a strcmp)
> over and over on symbols, tag them once upfront.
> 
> XXX do we also want to do __fentry__ ?

Might as well.

> XXX do we want an enum instead of a bunch of bools ?

Maybe, or convert the bools to bit fields.

-- 
Josh

