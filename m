Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4901735EB96
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347030AbhDND4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhDND4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:56:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:55:54 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k8so13460502pgf.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=AFWFHDUFI7Y9PY8k8BG7oxzX7QttBmdc0zzgW61jnYs=;
        b=myqvjuWdzKk0vpevYSXLdmUTOyFyiCsUqaLxsUnxEIYB+51maTF6Anu0owZmRwkoY7
         hJtAOCTIujyivSml+Bg/mDUx6RWYCTzeyts7wM4bhoketTP6LWouS7WgdPAphinCZj5q
         ThiiUNb23eENsraNybXBrFzXPklwad3q23knqH84gGY/ZWVn48bgJgQtig1eqodHH29y
         FeXj1PdTNjrvPUBksTNO0Fum2g0gNxmyc3Oa4NZnx7/oL2Roxt9pCz6y5FPtYfoWiCuF
         IUC7iUWzWqplD5/ZYpUWxUpAxdScdbMoSIAjCO2PsP/l15I61NHfqayiDm7kuhhDL1ti
         Esjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=AFWFHDUFI7Y9PY8k8BG7oxzX7QttBmdc0zzgW61jnYs=;
        b=pZmcLc4f0JusgGabBCvgl5YPXd7L0PAhVDmJSus0leGuc1tPjXQSZnEk4KtSo3gqPg
         gjT2wt2DfaYRSIJymmWDiJa8Ds/iw3KGFNM9fNsG2X2g6xodT8ZCMQHRpHPAIf9+Fjqz
         NqS7xpRr/sNukAD8F5yBCeheGENfdAjOeZ1o4Rr+ZiOMtuLaJ1Hjp61tT5s85hMkQ9oG
         J+1qJmMwY+B6nAREanHXhkxpEnBuCoYgNw2o2izuqp1Y4DJuse+7gSqDn5Z/pRATX67G
         kKXNZWC3F6qpS05c+yyeH5jM/M/Zkbla1PoeQM17CV0JxPlm8YXWl0uw05Wcr8XOUkZ4
         7JBA==
X-Gm-Message-State: AOAM533fjWoI4njLskDUA7wjsPMRGEIpVmGE1q5MpoUkxKzYNcqR8NWq
        dxV7AW1FQOxHfxBpo8FHCmyDEAePgCGP2g==
X-Google-Smtp-Source: ABdhPJwFNoMqquQx1OWVq0gCdN+Mdut2Dh9mMMcZcEKf0yTpl06AU/mt9KPvLWww8e4dCZ0odAGy3w==
X-Received: by 2002:a62:3486:0:b029:24c:34c0:3c7a with SMTP id b128-20020a6234860000b029024c34c03c7amr8292456pfa.36.1618372553611;
        Tue, 13 Apr 2021 20:55:53 -0700 (PDT)
Received: from slime ([139.198.121.254])
        by smtp.gmail.com with ESMTPSA id n22sm16257109pgf.42.2021.04.13.20.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 20:55:53 -0700 (PDT)
From:   xiaojun.zhao141@gmail.com
X-Google-Original-From: <xiaojunzhao141@gmail.com>
Date:   Wed, 14 Apr 2021 11:55:48 +0800
To:     mbenes@suse.cz
Cc:     josef@toxicpanda.com, linux-kernel@vger.kernel.org
Subject: the qemu-nbd process automatically exit with the commit 43347d56c
 'livepatch: send a fake signal to all blocking tasks'
Message-ID: <20210414115548.0cdb529b@slime>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found the qemu-nbd process(started with qemu-nbd -t -c /dev/nbd0
nbd.qcow2) will automatically exit when I patched for functions of
the nbd with livepatch.

The nbd relative source:
static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *bdev)
{                                                                               
        struct nbd_config *config = nbd->config;                                
        int ret;                                                                
                                                                                
        ret = nbd_start_device(nbd);                                            
        if (ret)                                                                
                return ret;                                                     
                                                                                
        if (max_part)                                                           
                bdev->bd_invalidated = 1;                                       
        mutex_unlock(&nbd->config_lock);                                        
        ret = wait_event_interruptible(config->recv_wq,                         
                                         atomic_read(&config->recv_threads) == 0);
        if (ret)                                                                
                sock_shutdown(nbd);                                             
        flush_workqueue(nbd->recv_workq);                                       
                                                                                
        mutex_lock(&nbd->config_lock);                                          
        nbd_bdev_reset(bdev);                                                   
        /* user requested, ignore socket errors */                              
        if (test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags))      
                ret = 0;                                                        
        if (test_bit(NBD_RT_TIMEDOUT, &config->runtime_flags))                  
                ret = -ETIMEDOUT;                                               
        return ret;                                                             
}

When the nbd waits for atomic_read(&config->recv_threads) == 0, the klp
will send a fake signal to it then the qemu-nbd process exits. And the
signal of sysfs to control this action was removed in the commit
10b3d52790e 'livepatch: Remove signal sysfs attribute'. Are there other
ways to control this action? How?

Thanks very much.
