Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3013E22BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 07:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbhHFEyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 00:54:14 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59243 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhHFEyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 00:54:12 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GgtRQ4Drfz9sV2;
        Fri,  6 Aug 2021 06:53:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VObFj0xlKBw1; Fri,  6 Aug 2021 06:53:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GgtRQ31z0z9sSt;
        Fri,  6 Aug 2021 06:53:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D0DFC8B7FE;
        Fri,  6 Aug 2021 06:53:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 343h2AQwUROS; Fri,  6 Aug 2021 06:53:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E4C8A8B7FD;
        Fri,  6 Aug 2021 06:53:49 +0200 (CEST)
Subject: Re: [PATCH v4] soc: fsl: qe: convert QE interrupt controller to
 platform_device
To:     Saravana Kannan <saravanak@google.com>,
        Maxim Kochetkov <fido_max@inbox.ru>
Cc:     kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, qiang.zhao@nxp.com
References: <20210803113538.560277-1-fido_max@inbox.ru>
 <CAGETcx8QC+AMXvmk4RB=LGp00QLVVX4uCeeruAjFnGq_irMh4Q@mail.gmail.com>
 <dff603dc-9038-71cb-bfcb-5abc24f17109@inbox.ru>
 <CAGETcx-evuv-A+A5v3-ubFZNvn_i+QSvg+tSW0OOgAd82-pytg@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <dc3411e9-d1e0-8a23-5d9b-1aee3880b4f7@csgroup.eu>
Date:   Fri, 6 Aug 2021 06:53:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-evuv-A+A5v3-ubFZNvn_i+QSvg+tSW0OOgAd82-pytg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/08/2021 à 06:39, Saravana Kannan a écrit :
> On Thu, Aug 5, 2021 at 9:35 PM Maxim Kochetkov <fido_max@inbox.ru> wrote:
>>
>> 03.08.2021 20:51, Saravana Kannan wrote:
>>>> So lets convert this driver to simple platform_device with probe().
>>>> Also use platform_get_ and devm_ family function to get/allocate
>>>> resources and drop unused .compatible = "qeic".
>>> Yes, please!
>>
>> Should I totally drop { .type = "qeic"}, or keep?
> 
> Sorry for the confusion. My "Yes, please"!" was a show of support for
> switching this to a proper platform driver. Not a response to that
> specific question.
> 
> I didn't look at the code/DT close enough to know/care about the "type" part.
> 

As far as I understand, Leo told it needs to remain, based on his answer below:

"From the original code, this should be type = "qeic".  It is not
defined in current binding but probably needed for backward
compatibility."


Christophe
