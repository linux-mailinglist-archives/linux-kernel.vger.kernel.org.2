Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2254641AA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhI1Hul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239310AbhI1Hui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:50:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D4A861130;
        Tue, 28 Sep 2021 07:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632815339;
        bh=069G8tB8j2m1OuvTkwtMxBgeFbtPHXQ7Zq+Yqw2rlIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofquDBpXMKS7RhdJn+jrSbTWGYdYXAI+Ccz+Ea5GxcAqom8/lbFsdARDbnvtJqFAG
         UKbBJVVmmAGO5ZiJ/wji0goQvI7edwID7C/YxFU2/5JyJk4pDO/RhrjTqL0v8QIZt4
         L8pf8NIEVyAYqG3jBls+8/2Y2kW0Fjs+agPFGmqY=
Date:   Tue, 28 Sep 2021 09:48:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fw_devlink logging improvements
Message-ID: <YVLI6WGEQcoTFbW9@kroah.com>
References: <20210915172808.620546-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915172808.620546-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 10:28:04AM -0700, Saravana Kannan wrote:
> These are pretty trivial logging changes that I would like to go into 5.15
> please.

Now queued up, thanks,

greg k-h
