Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716D935D91C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhDMHkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238673AbhDMHkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:40:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8B54613B8;
        Tue, 13 Apr 2021 07:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618299587;
        bh=UKLi8N7PpyoP0aTw1Rc06CM25uT52l0anJPWfPBcGOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQNwowknv7OnO5LeSWNcWfwmUf3l+pPLdAutNHoLNXy2Zf6aIBOSWhPi7kW15lYXd
         olyoch2ThrKxUlw853xBL6h+Z06xtJCNPfQzi2ZSQ/zjqae1CyYIIU/x3AqlpcvliM
         MlLtGG0VH6MoPms7iKfJAKl/frNSs1GcMU0sS5sw=
Date:   Tue, 13 Apr 2021 09:39:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove
 camelcase
Message-ID: <YHVKwEX8CvV7brRg@kroah.com>
References: <20210412210258.8061-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412210258.8061-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:02:58PM +0200, Fabio M. De Francesco wrote:
> Removed camelcase in (some) symbols. Further work is needed.

What symbols did you do this for?  What did you change them from and to?

Be specific, and try to do only one structure at a time at the most,
trying to review 1000 lines of changes at once is hard, would you want
to do that?  :)

thanks,

greg k-h
