Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73785451C34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354300AbhKPAOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:14:30 -0500
Received: from sender3-of-o52.zoho.com ([136.143.184.52]:21817 "EHLO
        sender3-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353623AbhKOWpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:45:02 -0500
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 17:45:01 EST
ARC-Seal: i=1; a=rsa-sha256; t=1637014891; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=R4DYxJ0D7TWoJ2kUxxw6g4H1oUr+7LngUMNiKntdvD2Ks1iCkDfFCUhiKX2xEKsoBfH3M+cctLU9dtnpV3wsA9k72MQ7E6fF7YUz4+i6S3cHN3GIyaRnN5tlgSVtazjiPNhS1VBe8485oglJceTcgYPAwFU3FxFgNFJd05UGjyU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1637014891; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=CSKP+pxK1OMbD7DMwbimwVntVO3vlL1NhMt2dPOplyc=; 
        b=G8JjF2+jkYkP7S+IOuKNMNaqWJwClenk6EzSqd5YNMc1PA0bylH06a09uUneO1M3YfJBmc+G8OZlAoFbyaxT0pjGcbx417zqiDY58aCSXVeAenN00ESSWqeAUUPHnG5a4ET4rSAnivE/GMCwZBeZwWbeghHuKlcQnsdiXJdFvqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=maidavale.org;
        spf=pass  smtp.mailfrom=ed@maidavale.org;
        dmarc=pass header.from=<ed@maidavale.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637014891;
        s=zoho; d=maidavale.org; i=ed@maidavale.org;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=CSKP+pxK1OMbD7DMwbimwVntVO3vlL1NhMt2dPOplyc=;
        b=Il+OW/KJ+qoFO7xk9trhHafNAq3xJiBMlm+HUC4KrLgvsBNjbq834a0LyTnMN1V7
        N7oYtcDuCVk2cgGN7WFjfAUGsMypPl5VZnx/kllC4XOdrNzh8HBBmK7FOv2jyMoWzu+
        wMkHP7wXiOhmsd5vEupLd7ozljRENZUNFXa9adDU=
Received: from [192.168.0.8] (94.14.150.106 [94.14.150.106]) by mx.zohomail.com
        with SMTPS id 1637014886071648.4298650141733; Mon, 15 Nov 2021 14:21:26 -0800 (PST)
Message-ID: <fb0bfe97-41c2-8aeb-f4f2-e8a07c5fda92@maidavale.org>
Date:   Mon, 15 Nov 2021 22:21:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v11 0/2] Update ASUS WMI supported boards
Content-Language: en-US
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, thomas@weissschuh.net,
        kernel@maidavale.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211115210842.11972-1-pauk.denis@gmail.com>
From:   Ed Brindley <ed@maidavale.org>
In-Reply-To: <20211115210842.11972-1-pauk.denis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2021 21:08, Denis Pauk wrote:
> Add support by WMI interface provided by Asus for B550/X570 boards:
> * PRIME X570-PRO,
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-I GAMING
> * ROG STRIX B550-E GAMING
> 
> Add support by WMI interface provided by Asus for X370/X470/
> B450/X399 boards:
> * ROG CROSSHAIR VI HERO,
> * PRIME X399-A,
> * PRIME X470-PRO,
> * ROG CROSSHAIR VI EXTREME,
> * ROG CROSSHAIR VI HERO (WI-FI AC),
> * ROG CROSSHAIR VII HERO,
> * ROG CROSSHAIR VII HERO (WI-FI),
> * ROG STRIX Z390-F GAMING
> * ROG STRIX B450-E GAMING,
> * ROG STRIX B450-F GAMING,
> * ROG STRIX B450-I GAMING,
> * ROG STRIX X399-E GAMING,
> * ROG STRIX X470-F GAMING,
> * ROG STRIX X470-I GAMING,
> * ROG ZENITH EXTREME,
> * ROG ZENITH EXTREME ALPHA.
> 
> I have added "ROG STRIX Z390-F GAMING" to list of supported boards in
> asus_wmi_sensors.
> 
> Could you please review?
> 
I don't believe "ROG STRIX Z390-F GAMING" should be added to the driver. 
It's an Intel board and looking at the UEFI image I don't believe it has 
the WMI interface present.

Ed Brindley
