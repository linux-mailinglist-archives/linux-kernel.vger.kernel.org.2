Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B35348A13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCYHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhCYHYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:24:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22A6D619B4;
        Thu, 25 Mar 2021 07:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616657079;
        bh=/PdiPyVXHRN/YOkXlMuwPObPxLvqED16vHP/ZJ+uZ20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxdCq6XFjaBIEquno7EHmkQKUFroMPpDAS3KHNv9iIu0kR8fFqlfjN2exUS3W/Hjp
         K0L9goHV4t0J1WW3Yp5zJ3mgE6K1u36CFJDfTuVJfIJB9dB9irljXQ1NCOGdKc3cyp
         ad0YKFYwr2V6miM5ecXHlQyAwWrFjBMHoMBvRbM7Di3D/fXZC0/t3MmTTU+qq5GWAm
         LGhiVAd1366ygL0Db+hbKXaltMA13+Y1+RtdSbWeyT1hDEKp3rPxsYviRGnlDokPWD
         UbilIabNgsBIu4+vAAK2QdRTSbHpueLU+HHq/xjdXBGeKNa+pNOmAOSsCiM9xanw5D
         /UZpybwEtSTrg==
Date:   Thu, 25 Mar 2021 12:54:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     kishon@ti.com, p.zabel@pengutronix.de, eswara.kota@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com, nathan@kernel.org,
        arnd@arndb.de, wan.ahmad.zainie.wan.mohamad@intel.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] phy: intel: Fix a typo
Message-ID: <YFw6s1qIquoOjfSo@vkoul-mobl.Dlink>
References: <20210320204055.26107-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320204055.26107-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-21, 02:10, Bhaskar Chowdhury wrote:
> 
> s/subsytem/subsystem/

Applied, thanks

-- 
~Vinod
