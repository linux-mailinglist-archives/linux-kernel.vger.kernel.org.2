Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A363A8240
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFOORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhFOOP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:15:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3537B61446;
        Tue, 15 Jun 2021 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623766426;
        bh=z/rvFhC5eUEsbyWibqMKVWnnQYBvsChHyCJrWOgUGOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLz2Gs/f1PKtbXlmRAK1iauvsrgTgNHSV2F4+UNDS5AkN4kWiajkagrxkR+w4CUjL
         Xguzbc2bhsKMh5UPalQjeRfRziFDkL7Ohytqo/QV76Y2onPD+4xhann1O8D2+5OjPv
         ZZcUrLWqgnHIzC9Ybz0aHmCokKpmspuZ0i3S9zYU=
Date:   Tue, 15 Jun 2021 16:13:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YMi1mIwOTLYs8h8/@kroah.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <YMiUgpRbfwMHCqD+@kroah.com>
 <DA86E839-4208-4535-B70C-ACFC94438BEB@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DA86E839-4208-4535-B70C-ACFC94438BEB@cortina-access.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:32:51PM +0000, Alex Nemirovsky wrote:
> The DT maintainers were CC’ed for the DT related files.  However, I suspect they won’t 
> ACK it until you ACK the actual serial port driver.

It goes the other way around :)
