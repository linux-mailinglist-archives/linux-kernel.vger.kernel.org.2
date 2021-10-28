Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE14643DA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 06:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhJ1EDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 00:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhJ1EDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635393672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDm1iBdNqWeiGldmOuAg2u1RcKbFKQ7rouatH/IZldQ=;
        b=CLn6tUq1eLFCuxbe+VI5HF+5C0eaWuHAsTVbKP9SMXaLx7hBUXXBgzgDO7uDtB91KNQI+5
        ygwZ3bZQbwku3sR2KzmW4SFECHXLRJHXNJz+MJlaQs4dnZ63Vehu0hOsIfDYrUFrq0+rUl
        EJ84Uhgq+Lb4L6OZwAb5F2p+kjpS4IA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-2DW1-dXTPuGr2td7pTT1eg-1; Thu, 28 Oct 2021 00:01:09 -0400
X-MC-Unique: 2DW1-dXTPuGr2td7pTT1eg-1
Received: by mail-qv1-f71.google.com with SMTP id gs5-20020a056214226500b00382f5609124so3961798qvb.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 21:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uDm1iBdNqWeiGldmOuAg2u1RcKbFKQ7rouatH/IZldQ=;
        b=sfchxETJpceYqOLGzEZjOrOGISGFUu5v0UWwO2a74riEdOvMNV7su3K2xNHVAYPwcy
         0yIs7dxs4vDXJyiplljbxJgQuBsrUwAZdkmx7uyIPRjXOrLX+RceWKsgDgPEAg2jxbSI
         EkXyq8P4ILlpoIgCKxPXrB2n9k5L6J/VgS0xvxgfBajSuf9/MS6WmF1ZYVZaACvTO4Xk
         3bD3cjNIwTQJitGIisBsEZtFIdGE0eZnxMGC19PuF9PS3AMOLnG/HCk26LUyjaquewzS
         DZmTAKZ0L+OXl3LbydZlqWMtMYLb6pDjs6Ac4edlyEKlESBFW0IUYTl9C5gzUrT6J26b
         6LPA==
X-Gm-Message-State: AOAM530W0U64OMZSzlCq1kgnpMSsQM8F5ri6QoUBY1DqH/Q7mQgJQJNQ
        ZZ6gGFlVHfPYaXp5IVL6PmKQ+0JzISjWT3HTiUJD9wz71BEMVGg5O0R/lq/pSBWyUyenkqRictN
        cJtL8XQ11vTOZIMrLCT1s6X36
X-Received: by 2002:a05:620a:c50:: with SMTP id u16mr1514881qki.203.1635393668801;
        Wed, 27 Oct 2021 21:01:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1UKpXmWUaI/dfdJ7+9cjZb8DUgTGQZUOjor4OWYIFNwC8ahO8kPwB7HDPsyxVXMMjtKAE6w==
X-Received: by 2002:a05:620a:c50:: with SMTP id u16mr1514861qki.203.1635393668618;
        Wed, 27 Oct 2021 21:01:08 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bp9sm1275967qkb.94.2021.10.27.21.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 21:01:08 -0700 (PDT)
Date:   Wed, 27 Oct 2021 21:01:05 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 02/16] objtool: Explicitly avoid self modifying code
 in .altinstr_replacement
Message-ID: <20211028040105.evz2inkbb7647ytr@treble>
References: <20211026120132.613201817@infradead.org>
 <20211026120309.722511775@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026120309.722511775@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 02:01:34PM +0200, Peter Zijlstra wrote:
> +	/*
> +	 * Alternative replacement code is just template code which is
> +	 * sometimes copied to the original instruction, For now, don't

s/,/./

> +	 * annotate it. (In the future we might consider annotating the
> +	 * original instruction if/when it ever makes sense to do so.).

s/\.$//

> +	 */

-- 
Josh

