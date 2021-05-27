Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF8B392600
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhE0ETG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhE0ETE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:19:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ED82613CC;
        Thu, 27 May 2021 04:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622089042;
        bh=YwtOc4Tg+Svlo8Jtch1J7zKrSacNyHqHkXOjHQoQy80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qtq06uHradeyvvzD9lycybgu0yS7WerZ66mMtt1xI+f4XmpegVEcv0y5kyuemA/Xi
         JIaV/T5d3WSF/0drps1HDQnT9EKcoNnwTAhYbqAYY5hf5UaOZc3XBB1qNERiD2NuF1
         DwC/N5K76SilGIM9XrRdUngxyDgrblBMiJ4NiyAM=
Date:   Thu, 27 May 2021 06:17:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     rafael@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion on how to fix "memory leak in snd_ctl_led_register"
Message-ID: <YK8dUDlYrq/RRzo7@kroah.com>
References: <CAD-N9QWYOE5vW=Q4wP74vV-TkrZUDFZxLn5OACX4jUC2ysEACQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QWYOE5vW=Q4wP74vV-TkrZUDFZxLn5OACX4jUC2ysEACQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 10:49:22AM +0800, 慕冬亮 wrote:
> Hi kernel developers,
> 
> The root cause of "memory leak in snd_ctl_led_register" [1] is
> unbalanced refcount operations in the device_add function [2]. This
> refcount issue causes struct device_private allocated in
> device_private_init unable to be deallocated, leading to memory leak.
> The details are as follows:

<snip>

Great, can you just send a patch to us to resolve the issue?  That's the
easiest way to resolve all of this.

thanks,

greg k-h
