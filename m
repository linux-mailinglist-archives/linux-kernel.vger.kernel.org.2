Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD03DC1A9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhG3Xp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhG3Xp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:45:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2438160F9B;
        Fri, 30 Jul 2021 23:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627688720;
        bh=Ss9rV0e7i1eDvLs/LIKsnpbhV0D1ytnC6PITlsMw1Is=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NQP2VqbUU5nsQNbOGgE/hJaYFD9aC5OKywbWDUYWkbfa4oxCnvILZRTuLCcFmByIG
         E1UswgrquTUX8h3PW6GBj252RFcEyLgU1GQjrmUl5N9IAhcKZQM1hIiRrphFzgKuAb
         eicTTj2tsfFtRxBBMzS/anG+Oj++mDZOaSFaRdwAaj0UvONutpTWobUCrhWo1l51lu
         0And5+LFiLe2KfhYdJwyiMGq+gLF9hlXul77lQMNm0TFjGNMQHaI9Q5ygHN14nv6/j
         JRvYdluQiM2mKJye01zrJjw0JGp92a5nUAnEFHR7ymdBp4wUsrEK55xSur+QoxSFk3
         EtJDOkPu7UyHQ==
Subject: Re: [f2fs-dev] [PATCH] f2fs: show sbi status in debugfs/f2f/sstatus
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210730190907.2072122-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f3331e35-9cfb-eb7b-8867-fb39f468c49d@kernel.org>
Date:   Sat, 31 Jul 2021 07:45:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730190907.2072122-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/31 3:09, Jaegeuk Kim wrote:
> We need to get sbi->s_flag to understand the current f2fs status as well.
> One example is SBI_NEED_FSCK.

Typo in patch title: "f2f/sstatus".

Please note that there is a sysfs entry /sys/fs/f2fs/<devname/stat/sb_status.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
