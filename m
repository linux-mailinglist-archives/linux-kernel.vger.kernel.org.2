Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7320B34FC74
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhCaJRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:17:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14976 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbhCaJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:16:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9LHB4my0zyNLP;
        Wed, 31 Mar 2021 17:14:30 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 17:16:25 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 0/2] clean up dt_binding_check and dtbs_check warnings of renesas,rsnd.yaml
Date:   Wed, 31 Mar 2021 17:16:14 +0800
Message-ID: <20210331091616.2306-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was then adjusted based on the following patch series:
[1] https://lore.kernel.org/r/20210323163634.877511-1-robh@kernel.org/


v1:
When I do dt_binding_check for all YAML files, below warning is reported:
/root/mainline/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: sound@ec500000: 'dais' is a required property
        From schema: /root/mainline/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml


make dt_binding_check -j24 2>err.txt
Before:
cat err.txt | wc -l
2

After:
cat err.txt | wc -l
0

make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/renesas,rsnd.yaml -j24 2>err.txt
Before:
cat err.txt | wc -l
130

After:
cat err.txt | wc -l
0

Zhen Lei (2):
  ASoC: dt-bindings: renesas, rsnd: Clear warning 'dais' is a required
    property
  ASoC: dt-bindings: renesas, rsnd: Clear warning 'ports' does not match
    any of the regexes

 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
1.8.3


