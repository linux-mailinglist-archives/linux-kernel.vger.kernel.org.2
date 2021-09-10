Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869E5406C92
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhIJM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhIJM7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:59:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D01CC61153;
        Fri, 10 Sep 2021 12:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631278711;
        bh=us/Tc8j70N27SKWwWOi+OQv+Gum4WXSd74uiK9tuqfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxWQg/xFoF9wZ15qeXl78n+kd/RFslORIMyclgJjAOXsy2ls012ZlwMJOwt1/3qW/
         J2bEnWLw/ojzQpzdHK+ZLtboNm3iQQH9DDL2uHiWdOt9iY7DMYAQATRHZiMFcz+46o
         ImUhOFL2vrLH4IWqYVL0n0N6wYAdaXJ7sMQsrV7k=
Date:   Fri, 10 Sep 2021 14:58:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Razvan Heghedus <Razvan.Heghedus@garmin.com>
Cc:     Peter Chen <peter.chen@nxp.com>, Johan Hovold <johan@kernel.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: ehset: Workaround for "special" hubs
Message-ID: <YTtWb5oYoQUYArAR@kroah.com>
References: <20210910124612.33368-1-Razvan.Heghedus@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910124612.33368-1-Razvan.Heghedus@garmin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 03:46:10PM +0300, Razvan Heghedus wrote:
> This Email, including any attachment/s, is confidential and intended only for the individuals or company named above. If you are not the intended recipient, please do not read, copy, use or disclose the contents of this communication to others. Please notify the sender that you have received this e-mail in error, by calling the phone number indicated or by Email, and delete the Email, including any attachment, subsequently. The information contained in this Email may be subject to professional secrecy (e. g. of auditor, tax or legal advisor), other privilege or otherwise be protected by work product immunity or other legal rules. Thank you.

Now deleted as this is not ok to have on a kernel patch :(
