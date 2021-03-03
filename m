Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4859332C917
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356318AbhCDBEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:04:22 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:43763 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451161AbhCDAaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:30:35 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4DrVDq4cgBzTs;
        Thu,  4 Mar 2021 00:14:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1614813243; bh=9Al8gOhS+5TsoAUhKvfuGCLTzMrzWMXb/SuOsE2dRMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=No/Latp5k3PxOfLYUE6aq3s2nKKnbtqmsE0HPbc0CpLnhN85/S36oJ74wYYbol0F4
         sekUJwSzGJ5SEFbrKjuR8sbsGZGPb2eoX/lGNVov8jKRtZVYZNXULZuQuxr9KLtsOT
         /8AuZAIC+Gco2Eo8UphAv8a+O9EGncmQRMTwd+6Fs8oxzCJWDz8rq3HbOIgN6LZfUu
         KDYAWmxiO1c4HK1tCdV5+rdrfGpwd+b9YQHPT/ufHiVYxqbTHZAX5LWbaMTs2kbQZk
         EvqyX/qzxyszh7hRX+Ngh+8vOEYl/Lx1mckYprCBafNRpRgivKC4LAJr2mi8dokQQ/
         WKQIESpAowACg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 4 Mar 2021 00:13:56 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 06/11] pragma once: convert include/linux/cb710.h
Message-ID: <20210303231356.GB22628@qmqm.qmqm.pl>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <YDvMkmgEjkDD08pC@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDvMkmgEjkDD08pC@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 08:02:10PM +0300, Alexey Dobriyan wrote:
> From 1c4107e55b322dada46879837d4d64841bc5f150 Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Tue, 9 Feb 2021 16:56:54 +0300
> Subject: [PATCH 06/11] pragma once: convert include/linux/cb710.h
> 
> This file is concatenation of two files with two include guards.
> Convert it manually.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
