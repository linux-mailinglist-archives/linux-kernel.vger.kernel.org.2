Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6563D357CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhDHGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhDHGld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:41:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA60461132;
        Thu,  8 Apr 2021 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617864082;
        bh=/zU1SlCaZTsU0PeIDHRx1Ni+FXc8yx1r7z2bbF2dzjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5V5o1A8FvYfXDbN3slbnKl/QgW5BUOgsjmpwafHlilpx8ael5ZlSxB0S5p/Aayif
         IxQLzvPk61KgX314LBZx/IkhO2N7sBct1bLjd3RRqAj/bIt2G35desDOOzb5DZ+I+8
         kqsqLx+Llco4ab8zJoueSOLALR5Iqh8TTZA2OZNY=
Date:   Thu, 8 Apr 2021 08:41:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add sync_state() support to clock framework
Message-ID: <YG6lj/cT5yqQdRpK@kroah.com>
References: <20210407034456.516204-1-saravanak@google.com>
 <161784175956.3790633.6032492675008535412@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161784175956.3790633.6032492675008535412@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:29:19PM -0700, Stephen Boyd wrote:
> Quoting Saravana Kannan (2021-04-06 20:44:53)
> > Stephen,
> > 
> > We can decide later if both these patches land through clk tree or the
> > driver-core tree. The meat of the series is in Patch 2/2 and that commit
> > text gives all the details.
> 
> The majority of the diff is in drivers/clk so presumably it can be
> merged through the clk tree if Greg acks the include file API.

Now acked, merge away!
