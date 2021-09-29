Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3541C18F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbhI2JZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhI2JZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:25:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB623613A9;
        Wed, 29 Sep 2021 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632907423;
        bh=/yZIgfcF5fpvYTWlWXCUU1IvR1FcIDtGeiuVADwG9GU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufrkPTRqBR3Sp6huH10ICdydg6MfjYQ9mXabmjEsgsAKIh/Zn5olcAKxhNMcwSdaP
         I5+BOnG5IZ7y8p02vx27hz6qUEhhC8ZTD8RUpgxug9ROjhj0OVrzZByUnD9tGvIUfd
         9aWnJZcMox8wUmi1lPAoOC6VqlMTIXaDtwxyRWTM=
Date:   Wed, 29 Sep 2021 11:23:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: ohci: add check for start frame in host
 controller functional states
Message-ID: <YVQwnKGvRJT/D62i@kroah.com>
References: <1632906444-11424-1-git-send-email-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1632906444-11424-1-git-send-email-zhuyinbo@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 05:07:24PM +0800, Yinbo Zhu wrote:
> The pm states of ohci controller include UsbOperational、UsbReset、UsbSuspend
> and UsbResume, among them, only the UsbOperational state supports launching

You are mixing the characters '、' and ',' here.  Please just use ','

thanks,

greg k-h
