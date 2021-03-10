Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D63346DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhCJSdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhCJSdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:33:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6434064FB6;
        Wed, 10 Mar 2021 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615401188;
        bh=Z2CaGn5K4ZujfVdcG3V5xCYiua3qUd3h5K8dQBTWztQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxc7N9+hK61zL3fhfqOyAMT/tKekugOhkimkHCeOKztpqxPXEf1+VKiAdLnzxsFiZ
         LCkrtRnar+ELpgeaY/rCqhe6MFatEx+V1XZuYidJarYdwp25YNrBOSjAwwOOopAOf9
         ttjxyrItVL9J8J6hdgnaQ8Gmp1SwAOLndwh3uINI=
Date:   Wed, 10 Mar 2021 19:33:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
Message-ID: <YEkQ4qS7tkwmjzDn@kroah.com>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615171203.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 08:53:25PM -0700, Shuah Khan wrote:
> This patch series fixes the following problems founds in syzbot
> fuzzing.

Thanks for these, all now queued up.

greg k-h
