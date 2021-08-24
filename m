Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68703F59C8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhHXIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233692AbhHXIVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA3A361181;
        Tue, 24 Aug 2021 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629793222;
        bh=wNRVT1QUCM5Sxjs8CxoaMMrgUbP2yeQycelOS4+LxNc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=ui2GWGuC1GtuowMbqjq6xZE5qpHNkxGHbHuM73spf4XvYyAERHCIdCcaIG2oHAMmG
         8NXNgJ96XJHn1ruFI1qWfxWF60uzNW96scXHmuK62sVv7N1ZgWnD7Wd56pYcMV36x3
         bwuG7wWqfQALsRZJV1wbCSW5DJPj6TCWtQW8ZBBGWSWaxlRhEGz8t1BYswgy/1+Xjf
         +TpQeEYzlyKlTgj1obpgEQZEtmrKYyGH7zlYjotMMtusoOTC5Jbnb3mQNd8DO7TVBY
         ZKiuOz7iTppMrNLe7B+zttugJo9Am9n16O8Trq/3/wcMPOQjTFftCleY5G5hzM2rMc
         3X2WO/auGDJMA==
References: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
 <20210823184449.2796184-3-Nehal-Bakulchandra.shah@amd.com>
User-agent: mu4e 1.6.4; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
Subject: Re: [PATCH 2/2] usb: dwc3: pci add property to allow user space
 role switch
Date:   Tue, 24 Aug 2021 11:19:40 +0300
In-reply-to: <20210823184449.2796184-3-Nehal-Bakulchandra.shah@amd.com>
Message-ID: <87pmu36ypp.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:

> For AMD platform there is a requirement to enable user space role
> switch from host to device and device to host by means of running
> following commands.
>
> HOST:   echo host > /sys/class/usb_role/dwc3.0.auto-role-switch/role
> DEVICE: echo device > /sys/class/usb_role/dwc3.0.auto-role-switch/role

A more important question that needs to be answered: why?

-- 
balbi
