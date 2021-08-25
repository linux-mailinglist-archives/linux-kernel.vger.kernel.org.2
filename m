Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B323F7118
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhHYI1U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Aug 2021 04:27:20 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:45876 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhHYI1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:27:19 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 17P8Q6qo007365; Wed, 25 Aug 2021 17:26:06 +0900
X-Iguazu-Qid: 34trdvrI6vzHvSyZzn
X-Iguazu-QSIG: v=2; s=0; t=1629879965; q=34trdvrI6vzHvSyZzn; m=WoRiB9Flbt8BP4+3OyJxp3/Bi6CQzfmha+qyqhldvUA=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
        by relay.securemx.jp (mx-mr1510) id 17P8Q4cs021625;
        Wed, 25 Aug 2021 17:26:04 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
        by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 7C1E631B1F;
        Wed, 25 Aug 2021 17:26:04 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
        by Switcher-Post_Send (Postfix) with ESMTP id 709B3190579710;
        Wed, 25 Aug 2021 17:22:41 +0900 (JST)
Received: from localhost [127.0.0.1] 
         by CNN1ESTR04.kioxia.com with ESMTP id 0003TAAAAAA0271F;
         Wed, 25 Aug 2021 17:22:41 +0900
Received: from CNN1EXMB03.r1.kioxia.com (CNN1EXMB03.r1.kioxia.com [10.232.20.152])
        by Switcher-Pre_Send (Postfix) with ESMTP id 65A1DA00617EA;
        Wed, 25 Aug 2021 17:22:41 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB03.r1.kioxia.com (10.232.20.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 25 Aug 2021 17:26:03 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Wed,
 25 Aug 2021 17:26:03 +0900
From:   sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH v2] nvme: update keep alive interval when kato is
 modified
Thread-Index: AdeYqq0GYCdtylBoR8GOhZA2v9EjoAAMlYwAACq71yA=
Date:   Wed, 25 Aug 2021 08:26:03 +0000
Message-ID: <ad3ea07be9174fb68c06c516192bf05e@kioxia.com>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
 <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
In-Reply-To: <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.44.200]
x-tm-as-product-ver: ISME-14.0.0.2080-8.5.1020-26364.007
x-tm-as-result: No-10--3.456500-8.000000
x-tmase-matchedrid: 6E41RGmUyPrUL3YCMmnG4h3Pziq4eLUfPknazlXMVpVYC5LPd7BvbbLs
        vs6J0rHdqH/x4QEYOK+w49/KRoE2DmJY9i/8SxOHrZZaiLezul0L8TGleseLPHls69bzQG/gjUQ
        jwBaLDpQVgI0fS7eHxWFV3cuPc/KP9bPHgjnnomBwju9EALAXQiIk3dpe5X+h7FgZhHZ4fUTzPv
        RcNNSOxtwDtnxW7PKIhVaMx/vKxVShmj3mg7kbBW/6CCblACLhTFQnI+epPIYRQQ4kFqjjJAtBe
        8tVCKUeoi+ZsUmcLQSzaFs1abK0x5soi2XrUn/JIq95DjCZh0zOjM6qu6GAtwfSeK1uwILztO9r
        zDWbK3wqtq5d3cxkNffvWahKfRU4ZJrYsGIvodVf/Sgxp6O06oaDRBK+cuxquIenSbtVLhWeNA7
        blM9Pflr0nVq8TX+O5MhWtwfCk2x9s5ZA7ZT2jkei6YdY6OruPJXcPkgxEwmbYLZwudds349pbp
        RrbisdIMW4USIcKqueqD9WtJkSIw==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--3.456500-8.000000
x-tmase-version: ISME-14.0.0.2080-8.5.1020-26364.007
x-tm-snts-smtp: F0A5A65516F857071B5E67CE998DA067AF24CBAAC98F78215503956817D67AA52000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB03.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB03.r1.kioxia.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 5:42 AM JST, Sagi Grimberg wrote:
> > +	if (cmd->opcode == nvme_admin_set_features &&
> > +	    (cmd->cdw10 & 0xFF) == NVME_FEAT_KATO) {
> > +		/* ms -> s */
> 
> no need for this comment.

Thanks for your comments. I will remove this /* ms -> s*/ comment.

> > +		unsigned int new_kato = DIV_ROUND_UP(cmd->cdw11, 1000);
> > +
> > +		nvme_update_keep_alive(ctrl, new_kato);
> 
> I think you can now inline nvme_update_keep_alive here, no need to keep
> it in a function.

Does this mean the section below needs to be moved from core routine
to nvme_user_cmd_post function?
> > +	dev_info(ctrl->device,
> > +		 "keep alive commands interval on the host is updated from %u ms to %u ms\n",
> > +		 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
> > +
> > +	nvme_stop_keep_alive(ctrl);
> > +	ctrl->kato = new_kato;
> > +	nvme_start_keep_alive(ctrl);

Thanks.

