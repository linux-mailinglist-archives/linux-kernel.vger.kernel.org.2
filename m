Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F41A459B88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhKWFWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231894AbhKWFWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:22:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A1876044F;
        Tue, 23 Nov 2021 05:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637644777;
        bh=s2+X/Dsn5egmAanzElg2iQu3D1op/8JYzqhkY6R0B1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9F3pH7NnisPh1/tnsyZYJgedv5MHzvlgFsyY/u03a5Kxf023659hbCitgJnJ7+9P
         83Evkqb+lC/eA5daxdJyr+IAJyarDjBL2GLZZ8zjrOC6n7yBfV5SLGNsvihxLEOayR
         5yGKyHtN5jMyXrN+oI4clFAS2/4PRNmokc8aG73bvQY3gNCEx6HtgbaCAHSNfyhSec
         2l/oFM/TlykQ6frdZY2IaN5Jh/zQkkVKeJo6seG1STEtYFy6/F32E3CdlNkVz+4O4E
         XC4/KiQ2nP8++/909qWvZi/FCdZfy/2OSooZNUY2Q5dTiyyXsuBEACqznbjt58kb4J
         OCBr6QQ+d7C3w==
Date:   Tue, 23 Nov 2021 10:49:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     kishon@ti.com, amelie.delaunay@foss.st.com,
        alexandre.torgue@foss.st.com, linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: stm32: adopt dev_err_probe for regulators
Message-ID: <YZx55MrlupRxNpMx@matsya>
References: <1635172265-26219-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635172265-26219-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-21, 16:31, Fabrice Gasnier wrote:
> Change stm32-usbphyc driver to use dev_err_probe(), to benefit of
> devices_deferred debugfs in case of probe deferral.

Applied, thanks

-- 
~Vinod
