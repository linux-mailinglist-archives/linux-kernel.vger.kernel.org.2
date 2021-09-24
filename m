Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B014A417813
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbhIXQAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233624AbhIXQAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5184B6103B;
        Fri, 24 Sep 2021 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632499156;
        bh=PAR7BlYAjmlJP0J3j8ht+dIXX+6y42XOPNdW0RzDbGA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=nj0qxJh+scK8SwWd6UAtNTIHtybF3xPE1c8OPEkGsiBRv7LEEa9eN26YFse26frN9
         Ek/meLhCzhvhntnmJeLoO+oSJOOq9fnVu72LGWqRjeuHeqJPzdOAUsOnoc9AxEVK51
         sd2YjOwTNdsOIlIf0mdgvKOzSxFabl6mbXGIc9iPmFbvimI0m7kTMS7pm09CXKJlre
         W7KR9cBkrHhukYk6fF0ny1D22fuQoiJE0N9PNcX85x5/m1kav32MgMYJfnusTdCuSV
         S6UwSLDAVOJMzfNOQ//ld0j5reERtkwPG4FaOpoH7Gx9qVILTTP838a1MFDmRMtTPB
         kg4ejDr8vr3AA==
Subject: Re: [PATCH v2] NIOS2: fix kconfig unmet dependency warning for
 SERIAL_CORE_CONSOLE
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20210924002939.16562-1-rdunlap@infradead.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <30e414b8-0e3b-6344-5dd4-29e80ec58ba5@kernel.org>
Date:   Fri, 24 Sep 2021 10:59:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924002939.16562-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/21 7:29 PM, Randy Dunlap wrote:
> SERIAL_CORE_CONSOLE depends on TTY so EARLY_PRINTK should also
> depend on TTY so that it does not select SERIAL_CORE_CONSOLE
> inadvertently.
> 
> WARNING: unmet direct dependencies detected for SERIAL_CORE_CONSOLE
>    Depends on [n]: TTY [=n] && HAS_IOMEM [=y]
>    Selected by [y]:
>    - EARLY_PRINTK [=y]
> 
> Fixes: e8bf5bc776ed ("nios2: add early printk support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: resend to new maintainer

Applied!

Thanks,
Dinh
