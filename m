Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404A6457AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhKTDLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 22:11:16 -0500
Received: from marcansoft.com ([212.63.210.85]:49120 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236709AbhKTDLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 22:11:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B0FA54256C;
        Sat, 20 Nov 2021 03:08:08 +0000 (UTC)
Subject: Re: [PATCH 2/2] usb: typec: tipd: Fix initialization sequence for
 cd321x
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211117151450.207168-1-marcan@marcan.st>
 <20211117151450.207168-3-marcan@marcan.st>
 <YZZRMfchQ7Y6gPqQ@kuha.fi.intel.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <5af6f984-8a22-bbae-db94-fbbdb005cc04@marcan.st>
Date:   Sat, 20 Nov 2021 12:08:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZZRMfchQ7Y6gPqQ@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2021 22.12, Heikki Krogerus wrote:
> Hi,
> 
> On Thu, Nov 18, 2021 at 12:14:50AM +0900, Hector Martin wrote:
>> The power state switch needs to happen first, as that
>> kickstarts the firmware into normal mode.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Please resend these with the appropriate Fixes tag included.

Done, thanks for the review!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
