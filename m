Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65E445A217
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhKWL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236754AbhKWL76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:59:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A05A60F26;
        Tue, 23 Nov 2021 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637668610;
        bh=NC6yZndM+SMo93sDfL0D+r+DpQq6vNHTG6i5Ek0HvdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKPG4e2j3fuOL58QUJPoPyyCr7u6HUjY5juZvs58RGNVoCVT+ip1RMzfiO82BDrtk
         t/NF7JI8+cjS7sDkXw+aPuIk16x+x4Ujf1BrNPwionmabQeczS0fwlKju1g4pBXhdR
         ENWABwacarPKxOfVHU2BVipElE6QaALe8SodkbMp7itjD59Pj03HtaTD26HKeXfGW/
         fgVBA5hE5TSatjs6jEAz6oz/Cv6ZTfrh4OXoUHq/7ysx6oy8Dd5NBAMIf8TXQwz88i
         yST31RI/ykFAmrpX4EyYZmqrK8BqSd3h0rlOwHUSDIdym2T9NEx2cp9cD3d4MlRHob
         vsALBnTRP5Gmw==
Date:   Tue, 23 Nov 2021 19:56:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: I.MX: Fix typo in some comments of imx
Message-ID: <20211123115643.GB4216@dragon>
References: <20211113032156.48799-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113032156.48799-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 11:21:56AM +0800, Jason Wang wrote:
> Remove the repeated `configurable' in some comments in imx1-pinfunc.h
> and imx27-pinfunc.h.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Updated the subject as below, and applied.

  ARM: dts: imx: Fix typo in pinfunc comments

Shawn
