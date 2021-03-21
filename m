Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA23430B7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 04:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCUDJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 23:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUDJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 23:09:04 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF71AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 20:09:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g15so7213669qkl.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 20:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=f/4iqXfUBBV4H6ClbQNOrfLH1q9eF+zQCEV2tH/kBis=;
        b=mpsvqdPdzqsotKW/gNJSoVlXq2/sYVVXTPaKvcax5EdemvbiYNtUrBunJdut6+lteB
         j263JhN5JzX2fvExrFBA6/lAK+nxGdqrNdvwEBh4LNI8LQRzJtqdDUwF9iyVwlaZiS+r
         leBpnrdMrmpsyWvxuwgmckp2u4eW0plv6qYj6Om3qq7E1erdV0LQCjR2ycGC9GceQpKY
         Q68UQko2YgPeRK7qO0EuZmJuZeR5WV98gRQ9xIYH7pGqD8IY/bhSJgV3DNw07aKveybO
         9iHygAjW1zxj3I1vHSSXB1rOYYmn2AbL4FcHkRv58UKeAwECdB67vSTHfR5jZXBT38NU
         NXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=f/4iqXfUBBV4H6ClbQNOrfLH1q9eF+zQCEV2tH/kBis=;
        b=Lzw9kqCL34YHyNxdWHKWJ1wpjCcFzzUU5Wuq6at0/gVpFUGUXELx5uhClvo9JPFX4/
         ef7ZKLyVMAvFVC2A0ANqm66Ou25WRhTO2CCjNKpyBW0JF4km6HsIjrGgLhiRAD+VlTP9
         +eaE5R2bJbsK2Iwpj0XVCJShXYE3JIrE8YWOpl6dywkcQgmVFpSON9eLyr8sBIIAJacX
         7qC5Hf5YjEcAvYGiiL54omLh6DktTQhT5FQ/HQ98vBbvMw6m7ADrKDeHEEc48uFQbmek
         x7o07KlEyCglBL6tMOTjOkwJJFwItokLpzcax4FCZTByra4oOY76YaZ+T0AhPAw0P/zH
         YqVw==
X-Gm-Message-State: AOAM533CrIb4J3JEU629qXwt5JfghztFQ5R8HtNa5WElOtX7mI4SV+7O
        UwZ20Y0ifEWly9GHXt4Qedv+JnhREu5stRFZ
X-Google-Smtp-Source: ABdhPJyP6AkE8sZMeBrWaBXjpWRvJrLcF0UnRrI27MoTani1uLYCuKandRBhTJCRUxAKWW2aePbooA==
X-Received: by 2002:a05:620a:a92:: with SMTP id v18mr5379957qkg.417.1616296142911;
        Sat, 20 Mar 2021 20:09:02 -0700 (PDT)
Received: from debian ([156.146.54.26])
        by smtp.gmail.com with ESMTPSA id q15sm6775042qti.9.2021.03.20.20.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 20:09:02 -0700 (PDT)
Date:   Sun, 21 Mar 2021 08:38:56 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mhiramat@kernel.org
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Bootconfig ..too many deep level of header file
Message-ID: <20210321030855.GA18105@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        mhiramat@kernel.org, LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hey, Masami

 I was wondering why so many level of "deep nesting" of a particualr header
 file like this one :

 ✔ ~/git-linux/linux/tools/bootconfig/include/linux [patch L|✔]
08:34 $ cat bootconfig.h
/* SPDX-License-Identifier: GPL-2.0 */
#ifndef _BOOTCONFIG_LINUX_BOOTCONFIG_H
#define _BOOTCONFIG_LINUX_BOOTCONFIG_H

#include "../../../../include/linux/bootconfig.h"

#endif

I am surely missing some basic stuff...but...anyway, I have taken a peek on other files in the same dir and none have the nesting like that(the include ../ ...line)

Any specific reason? OR did you thought of keeping all the header file in one paplace(wildly guessing) ...


~Bhaskar
