Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F533732F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhCKM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233256AbhCKM5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:57:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21D6764FAB;
        Thu, 11 Mar 2021 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615467461;
        bh=SKOxvSdiyOG3ZHjASbR+SICZV200uV4/KxAMX8yFYjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3GbMlX2Z0RNjgGxQxpBMQzxwQPga9Ub6YivofGCM3I3b0ysY47uMRkDcvrEAaio+
         +yMgGmQDLKOUTC9T92hJuDlr2gmqt81zXQE7Xzym+jNoawDNaPjfEnhaGWeSF/3x34
         JBB6bKThoIetCiTmWLilFYm33OBeRZ5nl2JsbAaU=
Date:   Thu, 11 Mar 2021 13:57:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
Message-ID: <YEoTw7CoK7Ob0YR+@kroah.com>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <YEkQ4qS7tkwmjzDn@kroah.com>
 <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:34:38PM +0900, Tetsuo Handa wrote:
> On 2021/03/11 3:33, Greg KH wrote:
> > On Sun, Mar 07, 2021 at 08:53:25PM -0700, Shuah Khan wrote:
> >> This patch series fixes the following problems founds in syzbot
> >> fuzzing.
> > 
> > Thanks for these, all now queued up.
> 
> I send SIGSTOP to
> 
>   [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races leading to gpf
>   [PATCH 5/6] usbip: fix vhci_hcd attach_store() races leading to gpf
>   [PATCH 6/6] usbip: fix vudc usbip_sockfd_store races leading to gpf
> 
> because these patches merely converted NULL pointer dererefence bug to use-after-free bug
> by breaking kthread_get_run() into kthread_create()/get_task_struct()/wake_up_process().

I'll take follow-on patches to fix that other issue, if it's proven to
be valid.  It's nice to fix up NULL dereference issues as soon as
possible :)

thanks,

greg k-h
