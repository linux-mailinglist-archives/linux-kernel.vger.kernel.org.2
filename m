Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294430F797
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbhBDQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:21:22 -0500
Received: from de-out1.bosch-org.com ([139.15.230.186]:35858 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbhBDQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:21:08 -0500
Received: from si0vm1947.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 4DWkKt6W7jz1XLGSq;
        Thu,  4 Feb 2021 17:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key3-intmail; t=1612455618;
        bh=MReZAxd0EH5Y3aZiWiz9G5/9hRs7nvCb0wAkvoZVmxo=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=AcFwKYrC/VxGeuBQyR/kNR7OKpG9UPEaUFL34tl1Qvcz8xM0LUXcVZJOStz2DUqQ5
         cpTl+dslcNZdXBQs1SCq6CK+A2VBdFVWcTyDEba9x3qmV2aqjD4QRr3YDu3iSR70sa
         Ic9TS5pJx6vnLtPtaapRt1mtXOklACQ+ackNkSYA=
Received: from si0vm4642.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 4DWkKt6CLkz6CjR41;
        Thu,  4 Feb 2021 17:20:18 +0100 (CET)
X-AuditID: 0a3aad12-f07ff700000020f1-71-601c1ec268a0
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm4642.rbesz01.com (SMG Outbound) with SMTP id C9.BE.08433.2CE1C106; Thu,  4 Feb 2021 17:20:18 +0100 (CET)
Received: from FE-MBX2042.de.bosch.com (fe-mbx2042.de.bosch.com [10.3.231.52])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 4DWkKt5LQvz11ZQ;
        Thu,  4 Feb 2021 17:20:18 +0100 (CET)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2042.de.bosch.com (10.3.231.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 4 Feb 2021 17:20:18 +0100
Received: from FE-MBX2051.de.bosch.com ([fe80::9402:faf1:5852:4e2f]) by
 FE-MBX2051.de.bosch.com ([fe80::9402:faf1:5852:4e2f%6]) with mapi id
 15.01.2106.006; Thu, 4 Feb 2021 17:20:18 +0100
From:   "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
        "Streidl Hubert (BT-FIR/ENG1-Grb)" <Hubert.Streidl@de.bosch.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: AW: [PATCH v2] mfd: da9063: Support SMBus and I2C mode
Thread-Topic: [PATCH v2] mfd: da9063: Support SMBus and I2C mode
Thread-Index: AQHW+w22q4v1gg8dsUO4hgmyCKHsCKpIGVsAgAATqNA=
Date:   Thu, 4 Feb 2021 16:20:18 +0000
Message-ID: <75c383e09ba74ca2af98d01b9470f53d@de.bosch.com>
References: <20210204155201.120524-1-mark.jonas@de.bosch.com>
 <PR3PR10MB41426B0114614DED4C2687F880B39@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PR3PR10MB41426B0114614DED4C2687F880B39@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.237.215]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsXCZbVWVveQnEyCwZUWI4ul75cyW9z/epTR
        4vKuOWwWR/fcY7a4+ns9i8Xe1ovMFnf3z2V0YPdY8UnfY+esu+wem1Z1snncubaHzePzJrkA
        1igum5TUnMyy1CJ9uwSujOlLprAXvOWq+P9vAVsD4zmOLkZODgkBE4kb/z6yg9hCAtOZJJq/
        iHcxcgHZuxklLnUuZYdw3jBK7Jv8ghGiaj+jxOwnrCA2m4CdxP7Xb5hAbBGBfkaJCeeCQRqY
        BU4wSdxbfJgFJCEsYC9xv+M8WxcjB1CRg8T+/YEQ9VYSv2+uYAaxWQRUJOa/2wM2h1fAWuLj
        /qssEIsnMEo0/3oCNodTIFZiy4LTYEWMArISGzacB2tmFhCX2PTsOyvEOwISS/ZAxCUERCVe
        Pv4HFVeS+Dl9JSNEvY7Egt2f2CBsbYllC18zQywWlDg58wnLBEbxWUjGzkLSMgtJyywkLQsY
        WVYxihZnGpTlmpiZGOkVJaUWVxkY6iXn525ihMSp0A7GXx0f9A4xMnEwHmKU4GBWEuFNbJNK
        EOJNSaysSi3Kjy8qzUktPsQozcGiJM6rwrMxTkggPbEkNTs1tSC1CCbLxMEp1cCk6nRP5azY
        v/Ip9yYzZC24yBx5q3bGheBHJ/iPOhhyfBBfdY99sWvwiahlYi+qfPpszcKXcur+7zpraFgk
        Jrzs3d9znC4JKYxm9YpOs4L1+HmVI6frP1I7+uzGqlM1QTLTd0wRLJ509kdB4IGiL+d8zU+c
        Npl8/ofSWfdr6ee3Zt38dLrxY9+xzzJ267bz/Dp3Yv7jl4ui9aWLJBLqDs+PZPITnabAcmj9
        mRl5L48luv2VPPm1+2zEY5Ntx7KeV7dszeC3SYj6kyef8s07lfejtJDX7KsSnGW771z1cDSd
        krO+XfET41SVMyvPxgtcv7xg98bTs/5MWbqEZ2tYyx/v5MehIoX71qQFp7N2MGsUKbEUZyQa
        ajEXFScCAK/9QRRCAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

> > +	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
> > +		dev_info(da9063->dev, "I2C mode");
> > +		busmode =3D 0;
> > +	} else {
> > +		dev_info(da9063->dev, "SMBus mode");
> > +		busmode =3D 1;
>=20
> I think this should be 'DA9063_TWOWIRE_TO' rather than '1' otherwise I th=
ink
> you'll be setting 0 still here as it doesn't match up with the mask.

You are right. We need to fix this and send a new patch.

> > +	}
> > +	ret =3D regmap_update_bits(da9063->regmap,
> DA9063_REG_CONFIG_J,
> > +		DA9063_TWOWIRE_TO, busmode);
> > +	if (ret < 0) {
> > +		dev_err(da9063->dev, "Failed to set 2-wire bus mode.\n");
> > +		return -EIO;
> > +	}
> > +
> >  	return da9063_device_init(da9063, i2c->irq);  }
> >
> > diff --git a/include/linux/mfd/da9063/registers.h
> > b/include/linux/mfd/da9063/registers.h
> > index 1dbabf1b3cb8..6e0f66a2e727 100644
> > --- a/include/linux/mfd/da9063/registers.h
> > +++ b/include/linux/mfd/da9063/registers.h
> > @@ -1037,6 +1037,9 @@
> >  #define		DA9063_NONKEY_PIN_AUTODOWN	0x02
> >  #define		DA9063_NONKEY_PIN_AUTOFLPRT	0x03
> >
> > +/* DA9063_REG_CONFIG_J (addr=3D0x10F) */
> > +#define DA9063_TWOWIRE_TO			0x40
> > +
> >  /* DA9063_REG_MON_REG_5 (addr=3D0x116) */
> >  #define DA9063_MON_A8_IDX_MASK			0x07
> >  #define		DA9063_MON_A8_IDX_NONE		0x00
> > --
> > 2.25.1

Cheers,
Mark
