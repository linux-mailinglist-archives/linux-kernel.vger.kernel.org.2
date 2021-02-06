Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9F311F53
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhBFSXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:23:05 -0500
Received: from ciao.gmane.io ([116.202.254.214]:53164 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhBFSXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:23:03 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1l8SDs-0009Ou-FN
        for linux-kernel@vger.kernel.org; Sat, 06 Feb 2021 19:22:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: [PATCH 5.10 00/57] 5.10.14-rc1 review
Date:   Sat, 6 Feb 2021 08:22:13 -1000
Message-ID: <80b8b4af-1061-18b6-8f38-79d298323a07@sysnux.pf>
References: <20210205140655.982616732@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Cc:     stable@vger.kernel.org
In-Reply-To: <20210205140655.982616732@linuxfoundation.org>
Content-Language: fr
Cc:     linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Le 05/02/2021 à 04:06, Greg Kroah-Hartman a écrit :
> This is the start of the stable review cycle for the 5.10.14 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know

Compiled and booted on my machine(x86_64) without any dmesg regression.

Tested-by: Jean-Denis Girard <jd.girard@sysnux.pf>


Thanks,
-- 
Jean-Denis Girard

SysNux                   Systèmes   Linux   en   Polynésie  française
https://www.sysnux.pf/   Tél: +689 40.50.10.40 / GSM: +689 87.797.527

