Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77B831D2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBPWhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:37:33 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:50986 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230381AbhBPWhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:37:31 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 747A9412D1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 22:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received
        :received:received; s=mta-01; t=1613515008; x=1615329409; bh=Cs4
        QgwbeAOzFIsH1FyCEXJYMd3ifY+7SMDgOdzX/Uj8=; b=hntM70Wjj34fu/zGUHG
        fgrjMFELLO6NQ52U6HE1WIDomt25hm4IjaVpMXjiXkNht3OFlpa2ywSEFORhHGqK
        1ENBvyPMmEobBmXsF+VeDcbU2Sa4A5V2IjUAaCbiCHQCGjqf8vTXmPLR8GCHDRkx
        /CRJPpWollac/XNH+hHZOU1I=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tgLKiJLh9YPG for <linux-kernel@vger.kernel.org>;
        Wed, 17 Feb 2021 01:36:48 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3651D404CD
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 01:36:48 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 17
 Feb 2021 01:36:48 +0300
Date:   Wed, 17 Feb 2021 01:36:46 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     <linux-kernel@vger.kernel.org>
Subject: Build the kernel on macOS
Message-ID: <YCxI/vFJAMQuSQma@SPB-NB-133.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I'm not sure this is right forum to ask (due to high volume) but I don't
know about any other that fits better. Is there any interest in making
macOS a first-class host to build linux kernel?

I'm quite sure [1][2] (a lot of similar posts can be easily googled)
there's a demand to build Linux kernel on macOS and QEMU is available to
provide executable environment for Linux on any virtual (via TCG) or in
some cases hardware-accelerated platform of interest.

Back in 2018 I managed to build x86_64 Linux kernel on macOS with
crosstool-ng altough a some patching was required for elfutils to
compile the kernel with CONFIG_UNWINDER_ORC=y.

If one sends patches that helps to build Linux on macOS hosts are they
going to be considered at all?

1. https://stackoverflow.com/questions/64297353/unknown-options-when-running-makefiles-for-linux-kernel-building
2. https://stackoverflow.com/questions/10018764/building-linux-kernel-on-mac-os-x

Thanks,
Roman
