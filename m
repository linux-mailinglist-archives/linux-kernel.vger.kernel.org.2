Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7C30CA73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhBBStS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238855AbhBBSqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:46:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E87D64E34;
        Tue,  2 Feb 2021 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612291570;
        bh=M+aHxEgqOj6uA2WSz0ygNYosKXPU76ldSGGVi2GB8ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1GKg0KEdRMMvZRzvdMFpA6ZoznIeICgGaxkL4FjJjSb0xbgOwWcRXDjzzsHYBT6m
         qVzOCGmH1zHmPCgVrFCkXyAZUy5R/WVdDKRf182a/8Ia80eI/iwg0F1LyRa7NMk8Do
         QvHoi0tH7bxwN3jcINNua/IhccWoa7z6NJBd9Nso=
Date:   Tue, 2 Feb 2021 19:46:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, bleung@chromium.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Return void in typec_partner_set_pd_revision
Message-ID: <YBmd78/cTR4tYmTh@kroah.com>
References: <20210202095512.761214-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202095512.761214-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 05:55:12PM +0800, Kyle Tso wrote:
> typec_partner_set_pd_revision doesn't need any return value.
> 
> Fixes: 29b01295a829 ("usb: typec: Add typec_partner_set_pd_revision")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Thanks, now queued up.

greg k-h
