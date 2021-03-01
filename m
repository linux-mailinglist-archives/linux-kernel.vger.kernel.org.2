Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27953287C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 18:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhCAR23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 12:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhCAQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:26:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513EC061797
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 08:25:24 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q20so11837799pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 08:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ycv6tPFV54RzPGmhungvnOwocLrp9QqH1VI69Dzusc=;
        b=aA9D2udJ0qOUY6Jeebr1JSkdrierE7uesyUez0D6kBw/+1w2MpIG75A1IXyp3aWqHv
         zr4W/9ahh2PPLl/gd26mENmA4ASGa3OC7jODzk6UDtAHtgfd9Gr3VL1ykKrGd86aY3A0
         alChfQy6gO0q3EMoBTI+QwWSUzbWmamYhomP05uJ1RTdOrx0lhwu9M8oDY3syLvytLVa
         l6v7PrJcoxg8865DxZajUW5h+oD1Y8c7HOx+BtTt/76t2uH51ySRI2bOeSkV2UwgqG1b
         yhjTlCSTAjIycxmuEU4A1bwQ9HpnnYjX3/8xllW7L5rnZXvKUj0O1MYtp2o4N183aeRL
         9QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ycv6tPFV54RzPGmhungvnOwocLrp9QqH1VI69Dzusc=;
        b=SxAD7Ayyv4KNLZXflhfhBPhIN/ePMz5HcxnJlhzHJGnk92xXFwaFcO9WuX4StEBR3T
         AOlR+9LJ3M/X7TeNknP+xvGJJPS2hDDZV0lB08R9YmXbIuiFZW+E/nbiL1ZvFMDZmERD
         k/BYLOzlZsA7PcjUHoF966T3j0vLUHNdVXGsFrPcjNPz4ndVqS8VPEA6i3zlJgoX5KMz
         7k/YVzB3PxqSw9cA+8WTciBTnoG/RZ2ilQRxDwq4V/V/qGdQyWB4JudTlP0hAi8QgrWp
         KbUsCA326EtUgRVFfTIWUQ02PNJ4AIl5B0E1GD2PWXetPrNc6uvevHkkOw9yRGB0G7MY
         K9tw==
X-Gm-Message-State: AOAM530yKRIzs4WqnMPrQPi/IRXy6hKyKL254k+pLwGPg8ADoDUUMVDY
        71vZ/qB7mt7ISaVmPKxq0mZGdQ==
X-Google-Smtp-Source: ABdhPJy4Qarq/RrKsSzodQsOh9ioQIhORoD8aMKoRoqMdO5xoSTIF+h8CrinDTJ0NzQicRngoAJSAg==
X-Received: by 2002:aa7:98c9:0:b029:1ee:309c:6552 with SMTP id e9-20020aa798c90000b02901ee309c6552mr15508480pfm.71.1614615924172;
        Mon, 01 Mar 2021 08:25:24 -0800 (PST)
Received: from google.com ([2620:15c:f:10:5d06:6d3c:7b9:20c9])
        by smtp.gmail.com with ESMTPSA id c22sm17089954pfl.169.2021.03.01.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 08:25:23 -0800 (PST)
Date:   Mon, 1 Mar 2021 08:25:16 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kvm@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, pbonzini@redhat.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH 09/25] x86/sgx: Move ENCLS leaf definitions to sgx.h
Message-ID: <YD0VbJ1fUoZmt4Ca@google.com>
References: <cover.1614590788.git.kai.huang@intel.com>
 <e8eb1ac6272ef7698ce6fbdc43e43bf38f25c494.1614590788.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8eb1ac6272ef7698ce6fbdc43e43bf38f25c494.1614590788.git.kai.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021, Kai Huang wrote:
> And because they're architectural.

Heh, this snarky sentence can be dropped, it was a lot more clever when these
were being moved to sgx_arch.h.

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
>  arch/x86/include/asm/sgx.h      | 15 +++++++++++++++
>  arch/x86/kernel/cpu/sgx/encls.h | 15 ---------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
