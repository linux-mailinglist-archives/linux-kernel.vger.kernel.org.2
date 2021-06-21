Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA63AEA94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFUN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:58:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6BCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:55:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso25150pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o9p8RT2f/7XUjthgkleACKKBqWg4rXyZN+ioEdrcfpc=;
        b=ut1usfHc2xYgvfkU0LEGtCoLXNP10NyUOIIz5hskW7nTeJWxS24dyt2quu/ZImSFwu
         NaRhKP02a6Agz3T2vxgGqjLacHfedIW1Cbo6WpsXBfmdj4awNa2t2nBf4NCu1QEJ+ZND
         83lPz3fV4ftdL2Jdb8uyR0uDgoI9QP6DmkonDq0/189kd0a2JaLugU3HtU1EwiG0Qkyx
         fh6ux0UeQDo5bJRTrK9z2YR1r21axVKYDaTG9+Rm7eiq+lnpCLBiWZcyCB8wpW9bZw/U
         QIKyZwM99m5uSrnFm9PCOt1IZnqHignF+zUKYRzU1pnIcZxq2xBQzUVQVQzMgNniNq/K
         pX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o9p8RT2f/7XUjthgkleACKKBqWg4rXyZN+ioEdrcfpc=;
        b=o90wMVH9t7UFrqKwsOS3Q/Y38EHb9lD2IhVd+48xaKRlnK9/CyXVLNRp7/ARUzW84P
         E1VxhO+OWMgBnSPnFaD16qMBoGemahYwhuWPNiUxsNpi367dwktocHLXjtg2LN1xzVD6
         Ty1Lw0QQqs90wd9STNWXbL4Ob/odpbftFa6CVkidcbNl3WWgOLk/NDjIQjt6TsmA5zuz
         XK/Kx+pGLIN14w4Xj8xH1uE8nxMn7gXW/2vcYS/dTlSEFIdYuAj6BJhJPLvrphpewivg
         go9pESvQWIX5IMeXG3kTB7/6pg5/wcd0iL9/+ibE4B+OZXOVjci3OGLS/VQpoAqAwxGo
         NeMA==
X-Gm-Message-State: AOAM532+hnyythMysVGhJ7hv+l8zc/IPA53SDacmI+FkkEn8PscSx9x7
        0a5bjEuv+FcVodbEbwa0mrA=
X-Google-Smtp-Source: ABdhPJxc1cAtv4pgRzzOtG/P5Y94ypdmp/68e3bc9ZgsIESJifSz8S0+GCpkTYi7ml1HfLA+/5idRw==
X-Received: by 2002:a17:902:f54c:b029:124:109f:fd6e with SMTP id h12-20020a170902f54cb0290124109ffd6emr7336829plf.67.1624283752261;
        Mon, 21 Jun 2021 06:55:52 -0700 (PDT)
Received: from [192.168.1.123] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id v6sm17817995pgk.33.2021.06.21.06.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 06:55:51 -0700 (PDT)
Cc:     akira.tsukamoto@gmail.com
Subject: Re: [PATCH 1/5] riscv: __asm_to/copy_from_user: delete existing code
To:     David Laight <David.Laight@ACULAB.COM>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
 <1b454390-cee5-a414-509b-3adb25ec0330@gmail.com>
 <fc86aa3f50a24a30891bf032aef591cf@AcuMS.aculab.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <1b96e0c6-bbfa-8ef1-c227-f4f5d02d0072@gmail.com>
Date:   Mon, 21 Jun 2021 22:55:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fc86aa3f50a24a30891bf032aef591cf@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/2021 8:45 PM, David Laight wrote:
> From: Akira Tsukamoto
>> Sent: 19 June 2021 12:35
>>
>> This is to make the diff easier to read, since the diff on
>> assembler is horrible to read.
> 
> You can't do that, it breaks bisection.

I know, it is intentional, I explained it on the other thread 
with Ben Dooks.
I just focusing make it easier to be understood of what the
code does right now.

Akira
