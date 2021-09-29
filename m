Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF241C020
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbhI2HwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244241AbhI2HwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:52:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA366613C8;
        Wed, 29 Sep 2021 07:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632901831;
        bh=n2bdQEu+ZHc2F7R1x0Q9U/cUozwpEKEnFR7JljWmwYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Su/COERiJl50sM5Bego2nlzYEv9i7m4s0OYbYXhl/KXUPTap0ccdIq4p3xiRzUXNj
         mdHU7xzMtoOT8caqVdGN03RPi2INa2rWHFoK3GiiCorD/O/iSUBPpv21QS7eRuLoBZ
         0L+xRKeyS/8T5v4DV94eZEG5eKwdjzOHzSVAUi3s=
Date:   Wed, 29 Sep 2021 09:50:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v0] usb: ohci: add check for start frame in host controller
 functional states
Message-ID: <YVQaxS3vjvZuT9JP@kroah.com>
References: <1632901259-32746-1-git-send-email-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1632901259-32746-1-git-send-email-zhuyinbo@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:40:59PM +0800, Yinbo Zhu wrote:
> The pm states of ohci include UsbOperational、UsbReset、UsbSuspend、UsbResume
> , among them only the UsbOperational state supports launching the start frame
> for host controller according the ohci protocol spec, but in S3/S4 press test
> procedure, it may happen that the start frame was launched in other pm states
> and cause ohci works abnormally then kernel will allways report rcu CallTrace
> . This patch was to add check for start frame in host controller functional
> states for fixing above issue.


Odd use of punctuation :(

> 
> Change-Id: Ic5c2c0a41d01d9396a9452f3eb64acc52b4cbf76

Always run checkpatch.pl on your patches do you do not get grumpy
maintainers asking you to run checkpatch.pl on your patches.

and what does "v0" on the subject line mean?

thanks,

greg k-h
