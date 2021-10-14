Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC942E45F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhJNWrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:47:45 -0400
Received: from phobos.denx.de ([85.214.62.61]:60070 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhJNWro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:47:44 -0400
Received: from crub (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1085F8362E;
        Fri, 15 Oct 2021 00:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1634251538;
        bh=1ET+geriuu8L+Dmd2g3Rt+4fFHnoen8mF94NyL50W5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jScZEwA/u78jDWaFuFhdO78tBzD/Tw5jNP4JCaFoWmX/SjkoH6RNfJGTOP+4ppROL
         aq+21kESBzW6zjMFydHhteggEeQwWyotywloQUnrsEKQFmRkZsOqv+IW2tU3f956Lp
         suurMEEZd4ld0jwIdARjOwOKZRGEFqkB5EoXlVE3NqlpwZgjh5q9VrwgUbdUJ+/iaz
         DwLL3z33h/nnOjY+3SSoRZT5suQ1D849oSPQF8E4+yFA3AjFB+HSTPKg4DUFFZZOzB
         6X/RjjBxVnHfDw30aO3JHr6n4XIezZG89VeT/g0QyDHtW+CVn7emgmjdm6SRCrljV/
         1eeUI1SIC+X5w==
Date:   Fri, 15 Oct 2021 00:45:37 +0200
From:   Anatolij Gustschin <agust@denx.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/mpc512x: dts: fix PSC node warnings
Message-ID: <20211015004537.7afde240@crub>
In-Reply-To: <CAL_JsqJQ8_3+pwT0a-gj5iSUSo3kYZXFraejjBGObNHpB+xcTg@mail.gmail.com>
References: <20211014113123.2358-1-agust@denx.de>
        <CAL_JsqJQ8_3+pwT0a-gj5iSUSo3kYZXFraejjBGObNHpB+xcTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 07:33:26 -0500
Rob Herring robh+dt@kernel.org wrote:
...
>> +++ b/arch/powerpc/boot/dts/ac14xx.dts
>> @@ -301,13 +301,21 @@
>>                         fsl,tx-fifo-size = <512>;
>>                 };
>>
>> +               /delete-node/ psc@11400;
>> +               /delete-node/ psc@11500;  
>
>That's an odd way to fix this, and means every user of the .dtsi file
>with these nodes will have to repeat the same thing.

okay, in v2 patch I've extracted the psc nodes to files which
can be included and extended individually.

Anatolij
