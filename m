Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8107936CB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhD0TEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0TEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:04:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCDF4613EA;
        Tue, 27 Apr 2021 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619550210;
        bh=LgogxfRraKrP6lC0pv8P+3VyNYszFCRRBcn/VtBnwiw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NfAfKGiG2q0TE9zyb5VOwhfbj1QvgOCu+heNdCy9JX4Hh6Y17SJzfFBUVuwXfVDMw
         nvzuA3VbVTMjBCwZRLUuOhi8Q7f9yYSIrbdj85cOgeLgARw19XDl0ybi875z73IG0y
         9jChvhoDd9Zat3ZwV0DMOwMinAkvVRT45U3gDWW2HBd6FykdZXmS+vFpeIadt7xVBU
         nLWFcWSrN3eCAH0nfK/lj5ftiJHgx72qrSs3e9Uv+1lyu0/dARsjlssuXWbw4OlVu8
         6st6uHj5x1vWu93sq44q3Zro2YP1Z314XM3Q/lI4D9DnwFGm2Cq0LhEMKsg5jofO2x
         Fzmy3lW6Mhyzg==
Subject: Re: [PATCH 162/190] Revert "dmaengine: qcom_hidma: Check for driver
 register failure"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Vinod Koul <vkoul@kernel.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-163-gregkh@linuxfoundation.org>
 <YIgkAw8UVh4F6tQB@kroah.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <811891cb-8749-152d-84ff-ed925e278f0f@kernel.org>
Date:   Tue, 27 Apr 2021 15:03:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIgkAw8UVh4F6tQB@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2021 10:47 AM, Greg Kroah-Hartman wrote:
> The original change is NOT correct, as it does not correctly unwind from
> the resources that was allocated before the call to
> platform_driver_register().
> 
> As platform_driver_register() should never really fail here, I'll just
> revert this patch and maybe someone, if they care about this driver, can
> unwind the mess here.  Given that this driver doesn't look to ever be
> able to be unloaded from the system, failing the init call does not look
> to be a wise idea.

Please go ahead. I was out-of-office for the last few days.
