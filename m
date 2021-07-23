Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF293D3B45
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhGWM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:56:11 -0400
Received: from smtp72.iad3a.emailsrvr.com ([173.203.187.72]:53720 "EHLO
        smtp72.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234972AbhGWM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:56:10 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 08:56:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1627047093;
        bh=oyT3ABq96lQbr04+RuTXd5B3SB1UY1mP7HYVr9puHdg=;
        h=Subject:To:From:Date:From;
        b=PYZjzE2cy9QrSu3SOQvNShznR1zLYezg+kkyZi8oSgdAaV/q2hKjAH/LBgdavhXKE
         SQUuilCE7f0stUeOqrhJ3DTkm6r9vi1O/kNHqchBwS6K0Td/+YHzSO42bGpwETBYk/
         ruzKTsNqaji+czYlQG17a+XlhhgHEmSw5jSRwVTY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp2.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1833E442D;
        Fri, 23 Jul 2021 09:31:32 -0400 (EDT)
Subject: Re: [PATCH] Drivers: comedi: drivers: ni_routing: ni_device_routes:
 pci-6070e.c Lindented
To:     Artem Baxtiarov <baxtiarovartem@gmail.com>,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20210723122749.GA41336@ideapad>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <c2cbf48d-0946-3db1-6143-b41c3472aa24@mev.co.uk>
Date:   Fri, 23 Jul 2021 14:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723122749.GA41336@ideapad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: fa3c6abd-d724-40d7-adc7-45a2b010c23a-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2021 13:27, Artem Baxtiarov wrote:
> I found "Lindent" item in drivers/comedi/TODO.
> I used scripts/Lindent to indent
> drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
> 
> Signed-off-by: Artem Baxtiarov <baxtiarovartem@gmail.com>
> ---
>   .../ni_routing/ni_device_routes/pci-6070e.c   | 1227 +++++++++--------
>   1 file changed, 621 insertions(+), 606 deletions(-)
> 

To me, the results look worse than the original. (Perhaps `indent` 
doesn't grok compound literals very well?)

Also, as written in the .../ni_routing/ni_device_routes/pci-6070e.c file 
(and other files in the same directory):

/*
  * The contents of this file are generated using the tools in
  * comedi/drivers/ni_routing/tools
  *
  * Please use those tools to help maintain the contents of this file.
  */

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
