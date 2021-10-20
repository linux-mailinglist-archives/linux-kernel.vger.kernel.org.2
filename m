Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3519435554
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhJTVgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhJTVge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:36:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E0EB6121E;
        Wed, 20 Oct 2021 21:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634765659;
        bh=39l+H6YZAUu7cgZDNKRXdHPmtlK7qtLAIF4APhEsT0o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SeETTEdtUx1SNYTW+nPqMVLFoC0kXMekF0wm3MPF2u+45/BzDyYb50/IqMxr/6OwU
         xp6UUDD/7KPrBhoAeE8wG+l3ktg9N8Xy6ZpQPSGH+Cwxaept2Aa5Ui+yu+KX6koUSR
         QH4Mk2LIMtm/4zNYseahHtvA05k1metVXNW586YNWoiX1khg0r/jV+UVjMg1KKtIiE
         owOAfQ4OsDftAo8QYfzh0mlK2QbUBgq54fEcKd7Mp8cs7pgOAybcb7J0UipI3BFrn+
         cCkfGsNya3EZC8DX3B3DT78ninmBVxmI0k+QAWKJ1L2WnPjidJUheJDEA3eyMzpsNz
         qMgFfMjV1/H+A==
Message-ID: <f712c594-a8a4-5333-c908-cf43896f8c05@kernel.org>
Date:   Wed, 20 Oct 2021 14:34:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: MAINTAINERS: Add Dave Hansen to the x86 maintainer team
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <87zgr3flq7.ffs@tglx>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <87zgr3flq7.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 14:08, Thomas Gleixner wrote:
> Dave is already listed as x86/mm maintainer, has a profund knowledge of
> the x86 architecture in general and a good taste in terms of kernel
> programming in general.

Yum yum.

Acked-by: Andy Lutomirski <luto@kernel.org>

--Andy
