Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0592393F24
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhE1JFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234769AbhE1JFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:05:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F240B6124B;
        Fri, 28 May 2021 09:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622192654;
        bh=8JR/Us1KQ6sdoQE+D5ip4683taop+0uVGmCfuLN74TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2dtVsnlB95hAUsPLj6jALu4jMzHj7YIrUurHrrFPrAap5d56wIXPivE9pvcEy1Ca
         ENkgdePw5IIU8VIl3vM/rz/+OzD/elZLGmFj4ivojqeh9AyENG5lOuTobx6zt4QiXQ
         545/xxILg7IsnNQgREt2X8S7H5G2QdDQkTHaXXp4=
Date:   Fri, 28 May 2021 11:04:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] devcoredump: remove contact information
Message-ID: <YLCyCzsBNvHIpiu7@kroah.com>
References: <20210528100314.d419f6e8e2d2.Ica8076036c755d6f782becd62d04c41361323130@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528100314.d419f6e8e2d2.Ica8076036c755d6f782becd62d04c41361323130@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 10:03:14AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> That email address hasn't existed for a long time, and the
> mailing address is pretty useless; remove all of this.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> Greg, can you take this through some of your trees, since
> it's drivers/base/?

Sure, will do so later today, thanks.

greg k-h
