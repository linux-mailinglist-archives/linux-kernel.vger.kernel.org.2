Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C603059FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhA0LiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236860AbhA0LcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:32:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74D2720754;
        Wed, 27 Jan 2021 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611747105;
        bh=ja87wjQq2x+JMzQzVIwcuhdi86wzT+tS4QzbHlnkngw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/3zY85ikUnnyTpCh8uS0WFvmxvDnT52/M72h4DpJ+5q343oy6e0D3fGsrfbP6VO0
         aI3s8yWOa6dg0uvZnlhlTG++OlTcn2Ar4bFBstCyNRvGdeIJ/Mg8ZCvDoO14+Fzq6i
         7+/QfMz3bsS0HXpIl/oLfFRWm3SVdjIZz7DuCow8=
Date:   Wed, 27 Jan 2021 12:31:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Bixuan Cui <cuibixuan@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Zqiang linux-usb @ vger . kernel . org" <qiang.zhang@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/12] [PATCH v3 12/12] usb: misc: usbtest: update to
 use the, usb_control_msg_{send|recv}() API
Message-ID: <YBFPHk8s+vV7BD3M@kroah.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126184043.915235-1-anant.thazhemadam@gmail.com>
 <640bd2a0-89c2-b01b-4827-5d2f05b2fb90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640bd2a0-89c2-b01b-4827-5d2f05b2fb90@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:17:06AM +0530, Anant Thazhemadam wrote:
> Looks like the subject line got messed up for patch 12/12.
> I'm sorry about that. Do I have to resend the patch?

I can't apply it as-is, so yes, it will have to be resent.

thanks,

greg k-h
