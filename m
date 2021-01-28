Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97AA30704A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhA1HyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:54:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232178AbhA1HqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:46:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5B5B64DD1;
        Thu, 28 Jan 2021 07:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611819938;
        bh=epBZyxkfXi4OKFC9L33caaS5qsnoDxPXf2XG9Lg/ziM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wd14qfDw7OD1HeK/t5lf5iJN7KtYADT8uy8biCXKBalBRjqoxl9t2jcqhU+epsUof
         2oy+bVID2X4gtrG7HGBEQ8nF57VmMffjnMEZQ9KnW1/6CSGM6wMAMOv5G+GXw1ZIk+
         EeEgIBFNkNIgubFLtv7xWIeMWL6VQknYlGJ+l0VMmOMYU8DIadx+a9bsKF0IvUxUfo
         LZG1U9FBSTWdsDGYamIsyroWaMgBn+XTE6lPCYsQDiXr7r+8IzKq8hP2/yzU9FvK/E
         MOfWXrpQhzTYRHDTjcC37GySZPKBO/obm0Aq4UPZ5Xja8PjoT9mAySrP8HkjNHz5cv
         h5YtVBy+fAi9g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l51zy-0004BC-3h; Thu, 28 Jan 2021 08:45:50 +0100
Date:   Thu, 28 Jan 2021 08:45:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Christoph Schemmel <christoph.schemmel@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hans-christoph.schemmel@thalesgroup.com
Subject: Re: [PATCH] USB: serial: option: Adding support for Cinterion MV31
Message-ID: <YBJrrin9NwF3j296@hovoldconsulting.com>
References: <20210127195846.3663-1-christoph.schemmel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127195846.3663-1-christoph.schemmel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 08:58:46PM +0100, Christoph Schemmel wrote:
> Adding support for Cinterion device MV31 for enumeration with
> PID 0x00B3 and 0x00B7.
> 
> usb-devices output for 0x00B3
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=1e2d ProdID=00b3 Rev=04.14
> S:  Manufacturer=Cinterion
> S:  Product=Cinterion PID 0x00B3 USB Mobile Broadband
> S:  SerialNumber=b3246eed
> C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=cdc_wdm
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> 
> usb-devices output for 0x00B7
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=1e2d ProdID=00b7 Rev=04.14
> S:  Manufacturer=Cinterion
> S:  Product=Cinterion PID 0x00B3 USB Mobile Broadband
> S:  SerialNumber=b3246eed
> C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> 
> Signed-off-by: Christoph Schemmel <christoph.schemmel@gmail.com>

Perfect, thanks for resending. Now applied.

Johan
