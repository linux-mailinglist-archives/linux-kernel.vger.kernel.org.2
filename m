Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8442397B28
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhFAUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:25:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48356 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234513AbhFAUZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:25:22 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151KGZVC006875;
        Tue, 1 Jun 2021 20:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZfE7SpF3zwKpmWzVzP/aV3gFN8HgkKhmsX/IkQ5NQ90=;
 b=HGk4jkzeRVehwabYfdWDMotWuzuHXfIwtdhfrcw5Rw+WiAvM4hy4sCgH8ooEehQPrQvo
 yHu9iUmWSAJYYZY4bNiVcUCg8HGiVFnJ53bLFYC88QqtQ/UTwISDRANK+T13qeubmlKi
 CBVxU00pUEx1rrjCdbbLrtH5DqfQtTXr8GO3VLhZUHcyjJ855lUyWSmREO7jjVjg9aC+
 9H49FHZf1wMzcDiCR9YgUtbWDS1AsyzdvXNFH+oQplOlWL8+hV5qz3So57GwNLC9P+5g
 RKLrh3xXBFFm/BFSmIdn09HAh7g7dF42zkjuZ1v0vUcWI7ln5AF9tzHEBH+vP2ut9GyC tw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38wu57r0em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 20:23:25 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 151KKnrg040277;
        Tue, 1 Jun 2021 20:23:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38ubndfdck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 20:23:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 151KKCNk039093;
        Tue, 1 Jun 2021 20:23:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38ubndfdbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 20:23:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 151KNLOU030306;
        Tue, 1 Jun 2021 20:23:21 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 13:23:20 -0700
Date:   Tue, 1 Jun 2021 23:23:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ojaswin Mujoo <ojaswin98@gmail.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        phil@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: vc04_services: Need suggestions on trying to fix sparse
 warning in vchiq_arm.c
Message-ID: <20210601202307.GC1955@kadam>
References: <20210601200513.GA10204@ojas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601200513.GA10204@ojas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 2HUnrfun4ratf_ZYcNbEft3H1aqRaMtl
X-Proofpoint-ORIG-GUID: 2HUnrfun4ratf_ZYcNbEft3H1aqRaMtl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is not the Sparse warning, the problem is that this code is
a mess.  It used to very clearly buggy and I reported the bug.  I think
Arnd found the bug again independently and fixed it.

A couple weeks ago Al Viro looked at this code.  Here is his write up:

https://www.spinics.net/lists/kernel/msg3952745.html

It shouldn't take Al Viro dozens of pages of detailed analysis to try
figure out if the code is safe or not.  Your idea silences the warning
but would make the code even more subtle and complicated.

The right thing to do is to re-write the code to be simpler.

regards,
dan carpenter

