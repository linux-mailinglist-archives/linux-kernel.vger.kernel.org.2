Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D365459F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhKWJ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:29:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235244AbhKWJ3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:29:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F84060FC3;
        Tue, 23 Nov 2021 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637659604;
        bh=L3aYnsAl6WEuIFbrRqzvr+L3LKUML/0dKwN5GDnu2IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfIaT5v9J6gfQPnI6dyKPfnL9ZwJxT80Q0GB+p1JP2xi5++zZl8onubp9FRpxtwps
         F10ogYcaNvoA799+moMWDkrrRqFFwEpG6iVeHeYwp96xOZ3l40tniWmW9Onf7TnXl3
         wOmtXgST/G7ydJfv3f9KAqbgUEYAAHQ8V+bqkU00dZNjoaXIbMr65Vxkchm7NH1mB1
         BB7LuI6QzHY9cKG9m/c7ic/pcSEpNzmrwNdlvklT8IPpefP+UfAtvSbahh4L7YdRte
         S8vs2Y/oWX+o/r9ZzL5Mgi4fioON8Cyq9SXm5AGixgKLcd9R+sMSlzSbYoCE2BVTBj
         BZgZHiRoIu5DA==
Date:   Tue, 23 Nov 2021 17:26:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] arm64: dts: imx8: add cache info
Message-ID: <20211123092638.GZ31998@dragon>
References: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 02:26:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patchset is to add cache info for i.MX8M*/QM/QXP, then
> people could see the info from sysfs.
> 
> Peng Fan (3):
>   arm64: dts: imx8m: add cache info
>   arm64: dts: imx8qm: add cache info
>   arm64: dts: imx8qxp: add cache info

Applied all, thanks!
