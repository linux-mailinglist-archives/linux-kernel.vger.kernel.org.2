Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF06735F09F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbhDNJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhDNJST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:18:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7F786120E;
        Wed, 14 Apr 2021 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618391878;
        bh=YN96Uvkmgg+8I+8iRLeSEq1aMXpTalv1GdPru8xyO7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjknrE2Prr25xzO2uF6pxrBcxKn2ZoyjaxX60Anp0N/ApYQGnkGuip0Qc8Sxw0Ffy
         BNge6Tgn9ZkNecje3Ss60PstXP/pxqVGg3qd8+uIqCQSiEmukTve6rRidrragDU1fU
         QCg1qJCuuikCP80023OUTMZYhQaAeLjlTCV5dBMs=
Date:   Wed, 14 Apr 2021 11:17:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: Allow node addition to already existing
 device
Message-ID: <YHazQ33v4PY8kRHd@kroah.com>
References: <20210414075438.64547-1-heikki.krogerus@linux.intel.com>
 <YHayP0cTOGMSoPNR@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHayP0cTOGMSoPNR@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:13:35PM +0300, Heikki Krogerus wrote:
> +Greg
> 
> Sorry about that. Should I resend this?

No worries, I can pick it up, thanks

`b4` really is nice to use :)

greg k-h
