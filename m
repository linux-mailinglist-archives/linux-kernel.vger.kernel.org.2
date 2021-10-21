Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E577F436A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhJUSJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhJUSI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:08:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D564BC061570
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:06:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g184so1036670pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8OWfmO1AeD6F2LGYa8iDuDtuPM78L2809BLnB7xB0UI=;
        b=pLncGkH0BVHpvxocf0AiYFlXd3f5ppYoGN/CnnLMp5Ja7a8V+BgP9zQnchlhzBk9Wp
         bnKTxuV6HejmxGJYTzwZ19ffQ0/iXmirfnubVSb0ozrvD3qA9UQ21Oh7bz316yHZ/85q
         G6fmDEYJ2WhBA5OtVdbjVkuRnX9XRjrFTpXpM82iP8zaSpzNqxrcSjYMU35wlzoL7aEV
         Z3xVDFo+6+T64kknB1TLxvPTqu/6FfJXXWoiRtWAc2cl7ysodGwrBqYasoJQKYTL0FHU
         f0+UQZzy4OA90G1ouGcrmOYhp8VKZ10Gg+v0XO1me4qxVFcjkk1Lb1Yy0TdWeAbDh5WW
         tYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8OWfmO1AeD6F2LGYa8iDuDtuPM78L2809BLnB7xB0UI=;
        b=5Km6l08QgtR5XCq6HrKmZ0CF3r0pRQ5kudQE5immH+ZGL/QaOpe/Xv2aK1IfV43c+A
         +An/YdYoRWydswICaE0SxcDW8k2Q2JjlAGHiPSY+tlmNNY7PKGfDkP1yfXRfu90By2ol
         qRXb1N8D38uVU1eTW/5LFQEc1n8o6pkcSFEhzj+chTI12/RcV+D3vv75v+4JN3KCiIDn
         QpvwPXXcXlV2Jb6hXlynN1I/itiseA0AwshfIB58LuHza+OJs0tWkoNhBytsXtvY3wLB
         KWuOMWHJQ7iZ0BV9OqrUH0Yzlxmkq9PsL9CfojDM/d4u2724ST6f+mplXlAE+RPuuwxP
         7ADA==
X-Gm-Message-State: AOAM533/CJMvpPsHWF+PJz2krYR8aYJvnzKGcWGp1ijRVOT4C0n3gzmf
        C0geO7L9zsbb/U+MsRRAOoM=
X-Google-Smtp-Source: ABdhPJz4lc7UxocThFFGPM+5fVzdUEMmiOeHCmCBGzeyRezfnbIeF99mr3eKuiRZr3tpNvvnB8y9Ng==
X-Received: by 2002:a65:6554:: with SMTP id a20mr5593418pgw.107.1634839602239;
        Thu, 21 Oct 2021 11:06:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e6sm5976573pgf.59.2021.10.21.11.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 11:06:41 -0700 (PDT)
Subject: Re: [PATCH] irqchip: Provide stronger type checking for
 IRQCHIP_MATCH/IRQCHIP_DECLARE
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20211020104527.3066268-1-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <866c3d7a-0cc9-0b49-6437-64443abfdfc4@gmail.com>
Date:   Thu, 21 Oct 2021 11:06:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020104527.3066268-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 3:45 AM, Marc Zyngier wrote:
> Both IRQCHIP_DECLARE() and IRQCHIP_MATCH() use an underlying of_device_id()
> structure to encode the matching property and the init callback.
> However, this callback is stored in as a void * pointer, which obviously
> defeat any attempt at stronger type checking.
> 
> Work around this by providing a new macro that builds on top of the
> __typecheck() primitive, and that can be used to warn when there is
> a discrepency between the drivers and core code.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
