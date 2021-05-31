Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1B395629
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhEaHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:35:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35534 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhEaHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:35:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id DCDBB1F422B1
To:     "kernelci@groups.io" <kernelci@groups.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        automated-testing@lists.yoctoproject.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-members@groups.io, Shuah Khan <shuahkh@osg.samsung.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: First KernelCI sprint this week
Message-ID: <f94a4f66-d16a-95b4-95df-9e9cff65620d@collabora.com>
Date:   Mon, 31 May 2021 08:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A KernelCI sprint or "hackfest" is taking place this week,
initiated as a joint effort by the Google Chrome OS team and
Collabora.  It is a public event and anyone is encouraged to take
part.  This is the first edition, we're hoping to repeat this
exercise in the future with a growing involvement from the kernel
community.  The goal is to provide an opportunity for developers
to focus on improving kernel test coverage and automation.

To find out about KernelCI, please see https://kernelci.org.


There is a workboard on GitHub to track progress and see which
topics are being worked on:

  https://github.com/orgs/kernelci/projects/3


We are hosting open hours this week on a Big Blue Button
instance (same as Linux Plumbers Conference 2020):

  Monday 31st: May 13:00-15:00 UTC
  Tuesday 1st - Friday 4th June: 08:00-10:00 UTC, 18:00-20:00 UTC

The actual meeting link is not shared publicly here to avoid
abuse but please reply to this email or ask padovan or gtucker on
IRC (Libera) and we'll send it to you privately unless we've
reached maximum capacity.


Of course, please feel free to use this email thread to share any
ideas or comments you may have as well as the #kernelci channel
on IRC (Libera, transitioning from Freenode).  We're otherwise
expecting some kselftest improvements and kernel bug fixes to be
sent out this week and as follow-ups.  Stay tuned!

Best wishes,
Guillaume
