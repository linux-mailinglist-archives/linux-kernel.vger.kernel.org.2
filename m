Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73695364192
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbhDSMWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239095AbhDSMWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:22:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C998061221;
        Mon, 19 Apr 2021 12:21:42 +0000 (UTC)
Date:   Mon, 19 Apr 2021 14:21:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] linux/mount.h: Remove duplicate struct declaration
Message-ID: <20210419122139.lyrmfgrk5kp6rsav@wittgenstein>
References: <20210419113342.42849-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419113342.42849-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 07:33:04PM +0800, Wan Jiabing wrote:
> struct path is declared at 85th line.
> The declaration here is unnecessary. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---

Looks good,
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
