Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2933B20B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCOMEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhCOMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615809855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3YjKsx//HRAhlNTprHpT9wozi3+fVsXIFMRQPWdBipU=;
        b=DsBNKV79iQzi2dGNkX74Cg173adU/hRTaxvKN8yE0DB3gJcaQouJeBFIc6IG8xdyqPqY98
        f2goFTLmmKjO1BdSb/DVM8v0zSgSbhmzvpyuYl+WRhDD8bB78pJyo5llO8UZft4gRZw3P4
        hQgpJb04kjWdeMv6ay9uyNxCDhejfDQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-6_jxpCrVOw2WeMV6bJvObA-1; Mon, 15 Mar 2021 08:04:11 -0400
X-MC-Unique: 6_jxpCrVOw2WeMV6bJvObA-1
Received: by mail-wm1-f70.google.com with SMTP id n17so2791459wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3YjKsx//HRAhlNTprHpT9wozi3+fVsXIFMRQPWdBipU=;
        b=TTBhlv14Lq6sYuykbO2LpS9LI1/nWWYE5Q4s4QUInXD23YC+2JkMepV0fnfPw0SIZ+
         sTEfiwKH1kInFFU3uPV3Fj4CDmU6ixlKcjTchpV8b6j1YJ7IDfkABaGf2pufunlosFdd
         qJYTIy+IuXo1se5HRvyg2K0vRPOweIjYYTLj8GV7pOTxKPfgz1mgyUYrNXzZphKqZuzQ
         c/s9WUJtgIGA1tgElXE5poUV+nd1VcqgjADsX+Z2u236ml/TK0du40X2R8v6ak2uV4Ij
         5sM9pxy4K0eyp0M4ZFIHG8BLt0FWg2VYIPu/unkmpJfVNjFf2oUQsXb1JsKnL6albG5i
         PYaQ==
X-Gm-Message-State: AOAM531XXNzEekEvtA/n45g/fVW8GEvvix1MQmypkIpNuAPln3KVkhbz
        aZYuds5JnkIur4RrBH1HsMjebUvw0GDu+g5yT3lK/vmekcmJADipCG/pepSzH+LTTpMw33Sh84B
        0RsrTm6o0lTc42OSDa6mvroPw
X-Received: by 2002:adf:f948:: with SMTP id q8mr27196109wrr.296.1615809850625;
        Mon, 15 Mar 2021 05:04:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfaexDs/CFrOUeJgtIS5WT2AAyCBWiRRNpka1mPAWlmrJqPolX9L34kAfVIvrGhBjJZkAu+w==
X-Received: by 2002:adf:f948:: with SMTP id q8mr27196090wrr.296.1615809850464;
        Mon, 15 Mar 2021 05:04:10 -0700 (PDT)
Received: from linux.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id d13sm19170594wro.23.2021.03.15.05.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:04:10 -0700 (PDT)
Date:   Mon, 15 Mar 2021 13:04:07 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Tom Parkin <tparkin@katalix.com>
Cc:     lyl2019@mail.ustc.edu.cn, paulus@samba.org, davem@davemloft.net,
        linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] net/ppp: A use after free in ppp_unregister_channe
Message-ID: <20210315120407.GB4296@linux.home>
References: <6057386d.ca12.1782148389e.Coremail.lyl2019@mail.ustc.edu.cn>
 <20210312101258.GA4951@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312101258.GA4951@katalix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 10:12:58AM +0000, Tom Parkin wrote:
> Thanks for the report!
> 
> On  Thu, Mar 11, 2021 at 20:34:44 +0800, lyl2019@mail.ustc.edu.cn wrote:
> > File: drivers/net/ppp/ppp_generic.c
> > 
> > In ppp_unregister_channel, pch could be freed in ppp_unbridge_channels()
> > but after that pch is still in use. Inside the function ppp_unbridge_channels,
> > if "pchbb == pch" is true and then pch will be freed.
> 
> Do you have a way to reproduce a use-after-free scenario?
> 
> From static analysis I'm not sure how pch would be freed in
> ppp_unbridge_channels when called via. ppp_unregister_channel.
> 
> In theory (at least!) the caller of ppp_register_net_channel holds 
> a reference on struct channel which ppp_unregister_channel drops.

Agreed: ppp_unregister_channel() is going to drop a refcount from pch
in any case. So holding a refcount on pch is a hard requirement for any
caller of ppp_unregister_channel(), regardless of the channel bridging
code.

To lyl2019: Note that this refcount is (unsurprisingly) held by calling
ppp_register_net_channel().

