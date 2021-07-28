Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065233D8DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhG1MgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:36:04 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:51791 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234683AbhG1MgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:36:03 -0400
Date:   Wed, 28 Jul 2021 14:35:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1627475757;
        bh=TvHYmPpZwPVftzAxkx91mGu8M+DltKnGumbfjAWcsF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gD/jBPkxO3umiOH8mUZWDecHKAivY8jFaRpEsJgtJs8ZqQTmGtX2A9UMSnXY8Tw1p
         iKkNJIO7PtvytYtxIWCGyQTL1c9RFNIyPQsq/+p0ZnvtiKTs43MDI0lMjk5GhyBMfG
         O1yqBYgKYplMhCh1KNOWkunpNDmck5wASYZuWMHk=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] platform/x86: gigabyte-wmi: add support for B550 Aorus
 Elite V2
Message-ID: <087f704d-1cc0-4035-9561-74a0d569f2b9@t-8ch.de>
References: <20210726153630.65213-1-linux@weissschuh.net>
 <bba2f992-d392-4087-c32d-ae60bf05d9ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bba2f992-d392-4087-c32d-ae60bf05d9ff@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2021-07-28T12:01+0200, Hans de Goede wrote:
> On 7/26/21 5:36 PM, Thomas Weißschuh wrote:
> > Reported as working here:
> > https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/1#issuecomment-879398883
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> I will also add this to the pdx86/fixes branch and include it in
> the pdx86 fixes pull-req for 5.14 which I plan to send to Linus soon.

Thanks!
