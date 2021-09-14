Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D840B29F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhINPMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:12:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40786 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234104AbhINPMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aSkOupdM/e9FjIq7o0qLJhFrJ1UQp6hlcbG1zxBt/wg=; b=PSGDgM9aGrXFXoq3Uvt80r/nl3
        HvhMM9A89J42swmPlNS6/7V691UNTgcUsNDgkqQ5pdEBkbfq1X8wTDvM43YZEdXwWXyJ+aooMJG8G
        RkXQHwb/BOH5+DcCO6IlyzOlwhEt3Uob0NTj/ZWwtt9bNN/Eihk5jozFVgipHtg0GVWQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mQA55-006c3F-Jq; Tue, 14 Sep 2021 17:10:43 +0200
Date:   Tue, 14 Sep 2021 17:10:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] driver core: Add fw_devlink.debug command line
 boolean parameter
Message-ID: <YUC7c9BNuHPOEg4g@lunn.ch>
References: <20210914043928.4066136-1-saravanak@google.com>
 <20210914043928.4066136-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914043928.4066136-6-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 09:39:27PM -0700, Saravana Kannan wrote:
> When the parameter is set, it enables all the debug logs that would be
> useful for debugging fw_devlink issues.
> 
> I'll add the documentation if we agree that we should add this param.

https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html

It is better to make use of existing infrastructure, maybe with
extensions if needed.

	   Andrew
