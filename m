Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC73809A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhENMgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233613AbhENMf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:35:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18EE661106;
        Fri, 14 May 2021 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620995687;
        bh=cOWzIG4VmiwQW4SOllGPTyOGocuq1JikXRO9BMJUZN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyWyH0wSmWh99VujleLT9q3iORZhtktgISDiGsiLALmhs8H1N8Zjv/ojWE3zNs7MD
         PxwQ9E0hKbK2hhzhicCM4EPObFG9V8sYz+Ek1d/HW0tK9UGF0t5LwO578vnP6GswGM
         GPVPWZZf9emcl15uY9bupqJyL0WHIGAvgYLxqP9U=
Date:   Fri, 14 May 2021 14:34:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v1 0/2] drivers: base: Device links removal fix and
 cleanup
Message-ID: <YJ5uZMEpWXvtnJuQ@kroah.com>
References: <11761395.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11761395.O9o76ZdvQC@kreacher>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 02:08:16PM +0200, Rafael J. Wysocki wrote:
> Hi Greg,
> 
> Patch [1/2] fixes a device link removal issue that may trigger a "scheduling
> while atomic" error in some situations and patch [2/2] is a related cleanup
> on top of it.

Thanks for these, I'll take them on Monday after -rc2 is out.

greg k-h
