Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E01D3225A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhBWF7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:59:44 -0500
Received: from smtp.rcn.com ([69.168.97.78]:57990 "EHLO smtp.rcn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhBWF7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; d=rcn.com; s=20180516; c=relaxed/simple;
        q=dns/txt; i=@rcn.com; t=1614059940;
        h=From:Subject:Date:To:MIME-Version:Content-Type;
        bh=uoq1oCgLlTqpdDX/iUbLy7J1Wic=;
        b=dTfPiCzzs3ZTe3rRcmVFI6kiK+bgtR9TwI3MAXxp4OeHELiLb/dUgXPfB7Ik+TEi
        70d048lsYmkzQhu7nspn+YDWkhwwUxd1e6OA7F/WRjT9wI2npC9Kzp4kfpie6Dma
        bFQAHzWmtjCfQM9Tuuj9OGMWPhnPtql+ET9lOkL2lhxcoZ5DQmyVwMUbRJjl2OXu
        jrGRklGvE8rS7ZtuC0w+/VMg20QogYFme6Q3Yo5NuM4gV7iwx802qyNZCv/QeBBi
        jEnwcYnqbzyUFdStCdGuegyv/p8B7CDgkShXV/DhU2cWJjYq0gNJaRvvZziG37jJ
        tx0DwBT/Ddx6k6GjtBhSKw==;
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.4 cv=TPOA93pa c=1 sm=1 tr=0 ts=603499a3 cx=a_idp_x a=x5gWOx0sY5WO8mqg6s4djw==:117 a=KGjhK52YXX0A:10 a=FKkrIqjQGGEA:10 a=n5JTWFA-sQwA:10 a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10 a=l962JvNQ8v8A:10 a=17Swcp7twyYA:10 a=tclcd6dtLQvEqt9_mmAA:9 a=QEXdDO2ut3YA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: dGNhcm1lbEByY24uY29t
Authentication-Results: smtp02.rcn.cmh.synacor.com smtp.mail=tcarmel@rcn.com; spf=softfail; sender-id=softfail
Authentication-Results: smtp02.rcn.cmh.synacor.com header.from=tcarmel@rcn.com; sender-id=softfail
Received: from [10.33.66.2] ([10.33.66.2:55384] helo=md08.rcn.cmh.synacor.com)
        by smtp.rcn.com (envelope-from <tcarmel@rcn.com>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTP
        id CA/87-53000-2A994306; Tue, 23 Feb 2021 00:58:59 -0500
Date:   Tue, 23 Feb 2021 00:58:58 -0500 (EST)
From:   dr bharati ghosh <tcarmel@rcn.com>
Reply-To: dr bharati ghosh <drbharatighosh@mediacombb.net>
To:     dr bharati ghosh <drbharatighosh@mediacombb.net>
Message-ID: <1669456887.12281885.1614059938765.JavaMail.root@rcn.com>
In-Reply-To: <560849086.12279926.1614059683319.JavaMail.root@rcn.com>
Subject: Re: hi
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.17.40.112]
X-Mailer: Zimbra 7.2.7_GA_2942 (zclient/7.2.7_GA_2942)
X-Vade-Verditct: clean
X-Vade-Analysis: gggruggvucftvghtrhhoucdtuddrgeduledrkeeggdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfujgfpteevqfftpdftvefppdfqfgfvnecuuegrihhlohhuthemuceftddunecugfhmphhthicusghougihucdlhedtmdenucfjughrpeffhfhrvffkjgfugggtgfhiofesthejtgdtredtjeenucfhrhhomhepughrucgshhgrrhgrthhiuchghhhoshhhuceothgtrghrmhgvlhesrhgtnhdrtghomheqnecuggftrfgrthhtvghrnhepfeekudehleekteelkeeggfffleekudeijeeghfefhffhffelhfevudejvdevtefgnecukfhppedutddrfeefrdeiiedrvddpkeegrddujedrgedtrdduuddvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepuddtrdeffedrieeirddvnedpmhgrihhlfhhrohhmpehttggrrhhmvghlsehrtghnrdgtohhmnedprhgtphhtthhopehlohhgihhsthhitghsseguuhhflhhonhdrtghomhen
X-Vade-Client: RCN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

