Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B633B5938
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhF1Gln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:41:43 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:64198 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhF1Gll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:41:41 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S6Tx9k020334;
        Mon, 28 Jun 2021 06:38:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0064b401.pphosted.com with ESMTP id 39enyuggkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 06:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNno9nsJXPFJ5BRJgysegKaOhwnMFZajgYjph9QGDf4ZfBIWmyCfscsL9VUy99uldTscKTUnWvUXWgIqQ4gyIPK0U4WFcyA18lDFI/iA/f465jIa2nKTBrNaesMhf5joCArQOBzz1ZBfJ6+EVUlXEWYikmht6Iv6c2I1Ty2i3H7yQPv1xxFH8DwyGKRqXEs9BhE0lRHe5m95yNqHQ3Dnmg+p1kDU7m7RVZgWlvtl16WtcrCeIlhG0EHt9s4lNmXDrfV24ts6O2p//Qlc+/XK0dXkrTkiwhR7ZQNFuwUz1zwQHCNh8DF+HoYJCarjvu/3RTAdNwhXwJ2egCXqwsIjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlLvTA8HO+qs01b7VGQE7PXnN4rdMaBkPhEg4Yp3Czs=;
 b=YmNzy+WdPYnPWWgNguD7g7id9EXgM18oQGE0wF1aCGbZRQzznNI7HBANCKzLY2SQ4hAg9dYyT9lURaDQJTGv2RLRwjPNrn+RhUmsMrmOdc0qftZv5Pjju4aE9KX033PVcLrTxecv3v8sWUT7Ka2jQhoFIR6Nm914gvFKlvea1GWSgmDo7+tfRuT1Yk0HfqBKOxwXEZJDNGICRh+AoUimLvy9pqU7d4kv3shlMzqmnlMj8UxODsI+D696jqtniRQINEksD99gUC+h82RwHCl2k3MjKwg/GOcFV928f5hwjgePY7NPcHO+B9AbrVCavHWOi6z2UNtpMaZoutGgGns2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlLvTA8HO+qs01b7VGQE7PXnN4rdMaBkPhEg4Yp3Czs=;
 b=NW4hWK1ohVoYwxPVSUFut1wwWUrRFG/DXB5jXmOw8FzhBHuXpohXekGF4lrlpST8MsqQ0u2UgKjTP4n1C/oanP2a4cfeZSonj8ByKSTnZC1C6pzcR5nXi84xbDF7bn4CyMazkzhaBCNOnGlV8bzydukEYJEJzLwF95sSeoo0OW8=
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL0PR11MB3011.namprd11.prod.outlook.com (2603:10b6:208:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.24; Mon, 28 Jun
 2021 06:38:38 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::9967:5190:1cd4:bb93]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::9967:5190:1cd4:bb93%6]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 06:38:38 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "guido.kiener@rohde-schwarz.com" <guido.kiener@rohde-schwarz.com>,
        "dpenkler@gmail.com" <dpenkler@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [syzbot] INFO: rcu detected stall in tx
Thread-Topic: [syzbot] INFO: rcu detected stall in tx
Thread-Index: AQHXNOxiROmQQzHmRkmv5ly2P9jVGKq7cPCAgG3rU94=
Date:   Mon, 28 Jun 2021 06:38:37 +0000
Message-ID: <BL1PR11MB5478572825796B0F04E1E1FDFF039@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <000000000000a9b79905c04e25a0@google.com>,<CACT4Y+aF64oNZD7Vd04bj+KfBU5GqVobCbRPp2-x_Z6dEr8d3A@mail.gmail.com>
In-Reply-To: <CACT4Y+aF64oNZD7Vd04bj+KfBU5GqVobCbRPp2-x_Z6dEr8d3A@mail.gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 480be471-80cd-4cc0-8a7f-08d939ff5c90
x-ms-traffictypediagnostic: BL0PR11MB3011:
x-microsoft-antispam-prvs: <BL0PR11MB3011504FD74FF9313C72CA98FF039@BL0PR11MB3011.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SlNbptRpwyuz7uUlHQ+sPJm/JWDx2fBDrTvh3GLT3PoUzXSJCPpF2Yiq8Ywjszt2OXxbcGlQY75X/jvYAqxFrUkIhCeFPm9CSmtjNlNzWbhtTT7zEyTN14rpCRyd0bvCgMHq1gDGOzpUM380cxwmYYUpTC3MmeeCEj/1F0EZQ0uw+Gbn5rp4ljsAX7C6BoqFYxfvZeYN/1MZk4QMD5w9nZr29g+qVxVO7z6Co5MvBCsg2o94I76QVoR9H7yz7xjBHMWTLJhNiEIAy4kwvN8aQ1tOl1BNxOFXcdgazHUhtdGyulAN6Cm/1pTPphqRDJgREPe+oatf3vvni0MTthoQ7RA7Ado9XZRpTqriEIPnb46D9XBfaFFNsVbfoEzFNWYlKB4QeUgS4Vigjn1Iy1khB1PKHjBkWl1XMNtgGhUpI2H0oJyQDZE0LS+ZWO89+UECI4IDmQDBhT3RUe9Lx5GD9mZT+ggwDalQ9Eq07w5aJSR01uNjwt3FC1XshLibKEkCZN4Kv4dQOpHlVK3IrrrENRga2IM7EHjChBfLhMp1toNkqxf9twC6X2BAII8LNipGw+EfAKMs05sK7QMXxbRwtccEJSsXUAcnBQiKuUS12oRjzEWKk2fmzIH33g6zdOsoShiPr/bk8kNMHNNpu5WUBX6/YM/5bbTQVJIkOB3s42aPq/zsjxgsFz5mUDKE7UBD6Y7/s135Ddcg+wwk3qVKKaOiZ7KT8kPt5cBlIGQhMIgL1D230j7b1zbo8eJ9UCpR8J4GtotAdEi0zaB/yJde3ExCMN/oln9cEfAaXeXORyOdvoFA1nENyewwH6wvpZdmvszwj5LnNWR1cvIorJrOZxhu7WvAE/IljVBaveW56M5IqyUcD5x6T397B8BIF7XN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39840400004)(136003)(396003)(76116006)(6506007)(86362001)(9686003)(186003)(110136005)(122000001)(30864003)(55016002)(38100700002)(4326008)(7696005)(8936002)(66446008)(54906003)(64756008)(8676002)(2906002)(66946007)(53546011)(7416002)(71200400001)(478600001)(966005)(66476007)(33656002)(52536014)(91956017)(26005)(316002)(83380400001)(5660300002)(66556008)(586874002)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0YHHPc2B/coJwY7k9TdLqfSumPSyhz4UrnR82FvDUL7OR8bEbr9zr7Bkz3l+?=
 =?us-ascii?Q?/DzMJtVuh6vViJ4nRl8wBRfG308boQ4aVtW2xDlvtpFciduE23WLuMLlgHpX?=
 =?us-ascii?Q?nnhR1IYBGl+hL6K9y6MmGdTObbLWp7fgiCMy55uTTCh+3fls2KOmwh29B82v?=
 =?us-ascii?Q?NbFivDpCquQKGekP8KQ/FD8t86I5d6qjbquRUlZWfTXJDYoEGtIuhrJji+0r?=
 =?us-ascii?Q?FHEwN1pzvixLrJtrJSdyzJly++NjmNyZWGU7bNkdgEkf+mka1KV8JJapBofM?=
 =?us-ascii?Q?zOrbU+6t5gpNxn1zU9rPkGxZeBEXguIx45BsEps+bbFdU4a+KKyUVFRO/gga?=
 =?us-ascii?Q?yb9ZcrTnruqUxvp8C5hi9p+dEyML9EnaeSYS/xheERhdyg/oQN87gdj7mbHX?=
 =?us-ascii?Q?3pQlOPJRpu8of6310a/h4RqY9MNQjVEkhOq0Q9uELoOY1Fr5wK+npv/NZSFF?=
 =?us-ascii?Q?V0vBVSD2kHCDPT8R0gu16DqRWjLTcMm9xiRoat++7gg+EgS0Wo8GoGEOKUT3?=
 =?us-ascii?Q?IDnz89rxa1rPIrc2q5rjj4dKyKwnbO2oNRde7E/GwC9JYjdSfkcxRygl9Deq?=
 =?us-ascii?Q?ZeLsQZRFkiSIfZRfF71hDiCr1fx6Xsjv0TMsuJPhcvkw7PhrKQVOESsQQrvk?=
 =?us-ascii?Q?tsC2afAU36pTH0Dr33x+qJHqV2KQgNLdIfXa8UBP1Tcojq9w+jdk3pnZOet0?=
 =?us-ascii?Q?nZdnqA/8g9DVYeXbuSDJHrOh2W6uHeyifxlDyyPMynVuIEXktY7Me7d/E94Q?=
 =?us-ascii?Q?SA8buejMH17GO39GPrSOL5AMT7zlkX5ikkt7Vn9HOSEdX5nZg7goYRkaCeDS?=
 =?us-ascii?Q?i8Hf1cI0ei5YBXd/cP7EhDSeQaf+DwhDA+cpiWNuQNO4blvCNONZW2UH81Zp?=
 =?us-ascii?Q?Ymj5FnIiOeXjPVdXPxevH3w1TEyrxCZAVjZj7BS6CpzOu2xFi8lqDuH1c6Ko?=
 =?us-ascii?Q?0deTHa4pSlcuRerZK2sP2PA5GtqrdTwL8+DwNb5z7+qNIQc+bv8xXjui2/64?=
 =?us-ascii?Q?M2QQaobTh35gPOCmO0wgYhxHCXc64GOP+88wEchmTRVune69BzqboPcOrqWo?=
 =?us-ascii?Q?u/oI9tfIkCsOkWFLo9pmBvxrCPWM2BcnZi8VAYzZOywk/kT8YoWGX0RiOFhC?=
 =?us-ascii?Q?MN7/HXL9PrSD9Ed38zferFWgfVufovAnaMHm+1IPeMLA9O7atT4q9PnbydXh?=
 =?us-ascii?Q?iyMNXVaOFWtDBOnYIAfTudp1MXJIvOTBKR3BjmZkaqsebTflrOekEwKkScd0?=
 =?us-ascii?Q?eRR+ByHBoAD9iN6mwyh23mgXK81odzh+NFKXte2/84n+waBMrEOk2c1iC351?=
 =?us-ascii?Q?YQw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480be471-80cd-4cc0-8a7f-08d939ff5c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 06:38:37.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYPCEWKQy3ioG3dfE5D790DgQ+ftK776LNBuBPbXu9hOZA+0kKsNLXjbCZSlVM68arNhcqc5zSV6JDOVB59GVcdq+UsONC8cV3cHfNwKPLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3011
X-Proofpoint-ORIG-GUID: vrd-D4qb1vZSE3VNZ_tI6unYJNJilcdf
X-Proofpoint-GUID: vrd-D4qb1vZSE3VNZ_tI6unYJNJilcdf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_05:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Dmitry Vyukov <dvyukov@google.com>=0A=
Sent: Monday, 19 April 2021 15:27=0A=
To: syzbot; Greg Kroah-Hartman; guido.kiener@rohde-schwarz.com; dpenkler@gm=
ail.com; lee.jones@linaro.org; USB list=0A=
Cc: bp@alien8.de; dwmw@amazon.co.uk; hpa@zytor.com; linux-kernel@vger.kerne=
l.org; luto@kernel.org; mingo@redhat.com; syzkaller-bugs@googlegroups.com; =
tglx@linutronix.de; x86@kernel.org=0A=
Subject: Re: [syzbot] INFO: rcu detected stall in tx=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On Mon, Apr 19, 2021 at 9:19 AM syzbot=0A=
<syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com> wrote:=0A=
>=0A=
> Hello,=0A=
>=0A=
> syzbot found the following issue on:=0A=
>=0A=
> HEAD commit:    50987bec Merge tag 'trace-v5.12-rc7' of git://git.kernel.=
o..=0A=
> git tree:       upstream=0A=
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1065c5fcd0000=
0=0A=
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D398c4d0fe6f66=
e68=0A=
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De2eae5639e72033=
60018=0A=
>=0A=
> Unfortunately, I don't have any reproducer for this issue yet.=0A=
>=0A=
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:=0A=
> Reported-by: syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com=0A=
>=0A=
> usbtmc 5-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 5-1:0.0: unknown status received: -71=0A=
=0A=
>The log shows an infinite stream of these before the stall, so I=0A=
>assume it's an infinite loop in usbtmc.=0A=
>+usbtmc maintainers=0A=
>=0A=
>[  370.171634][    C0] usbtmc 6-1:0.0: unknown status received: >-71=0A=
>[  370.177799][    C1] usbtmc 3-1:0.0: unknown status received: >-71=0A=
>[  370.183912][    C0] usbtmc 4-1:0.0: unknown status received: >-71=0A=
>[  370.190076][    C1] usbtmc 5-1:0.0: unknown status received: >-71=0A=
>[  370.196194][    C0] usbtmc 2-1:0.0: unknown status received: >-71=0A=
>[  370.202387][    C1] usbtmc 3-1:0.0: unknown status received: >-71=0A=
>[  370.208460][    C0] usbtmc 6-1:0.0: unknown status received: >-71=0A=
>[  370.214615][    C1] usbtmc 5-1:0.0: unknown status received: >-71=0A=
>[  370.220736][    C0] usbtmc 4-1:0.0: unknown status received: >-71=0A=
>[  370.226902][    C1] usbtmc 3-1:0.0: unknown status received: >-71=0A=
>[  370.233005][    C0] usbtmc 2-1:0.0: unknown status received: >-71=0A=
>[  370.239168][    C1] usbtmc 5-1:0.0: unknown status received: >-71=0A=
>[  370.245271][    C0] usbtmc 6-1:0.0: unknown status received: >-71=0A=
>[  370.251426][    C1] usbtmc 3-1:0.0: unknown status received: >-71=0A=
>[  370.257552][    C0] usbtmc 4-1:0.0: unknown status received: >-71=0A=
>[  370.263715][    C1] usbtmc 5-1:0.0: unknown status received: >-71=0A=
>[  370.269819][    C0] usbtmc 2-1:0.0: unknown status received: >-71=0A=
>[  370.275974][    C1] usbtmc 3-1:0.0: unknown status received: >-71=0A=
>[  370.282100][    C0] usbtmc 6-1:0.0: unknown status received: >-71=0A=
>[  370.288262][    C1] usbtmc 5-1:0.0: unknown status received: >-71=0A=
>[  370.294399][    C0] usbtmc 4-1:0.0: unknown status received: >-71=0A=
=0A=
=0A=
=0A=
This seems like a long time in the following cycle,  when the callback func=
tion usbtmc_interrupt() find unknown status error, it will submit urb again=
. the urb may be insert  urbp_list.=0A=
due to the dummy_timer() be called in bh-disable. =0A=
This will result in the RCU reading critical area not exiting for a long ti=
me (note: bh_disable/enable, preempt_disable/enable is regarded as the RCU =
critical reading area ), and prevent rcu_preempt kthread be schedule and ru=
nning.=0A=
=0A=
dummy_timer() =0A=
{=0A=
restart:=0A=
         list_for_each_entry_safe(urbp, tmp, &dum_hcd->urbp_list, urbp_list=
) {=0A=
                     .........=0A=
                    ep =3D  find_endpoint(dum, address);=0A=
                    if (!ep) {=0A=
                           status =3D -EPROTO;=0A=
                            gotto return_urb;=0A=
                     }=0A=
                     ............=0A=
                    return_urb:=0A=
                              usb_hcd_giveback_urb();=0A=
                              goto restart;=0A=
                }=0A=
}=0A=
=0A=
Whether to return directly when we find the urb status is unknown error?=0A=
=0A=
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c=0A=
index 74d5a9c5238a..39d44339c03f 100644=0A=
--- a/drivers/usb/class/usbtmc.c=0A=
+++ b/drivers/usb/class/usbtmc.c=0A=
@@ -2335,6 +2335,7 @@ static void usbtmc_interrupt(struct urb *urb)=0A=
                return;=0A=
        default:=0A=
                dev_err(dev, "unknown status received: %d\n", status);=0A=
+               return;=0A=
        }=0A=
 exit:=0A=
        rv =3D usb_submit_urb(urb, GFP_ATOMIC);=0A=
=0A=
Thanks=0A=
Qiang=0A=
=0A=
> rcu: INFO: rcu_preempt self-detected stall on CPU=0A=
> rcu:    1-...!: (8580 ticks this GP) idle=3D72e/1/0x4000000000000000 soft=
irq=3D20679/20679 fqs=3D0=0A=
>         (t=3D10500 jiffies g=3D27129 q=3D416)=0A=
> rcu: rcu_preempt kthread starved for 10500 jiffies! g27129 f0x0 RCU_GP_WA=
IT_FQS(5) ->state=3D0x0 ->cpu=3D0=0A=
> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now e=
xpected behavior.=0A=
> rcu: RCU grace-period kthread stack dump:=0A=
> task:rcu_preempt     state:R  running task     stack:29168 pid:   14 ppid=
:     2 flags:0x00004000=0A=
> Call Trace:=0A=
>  context_switch kernel/sched/core.c:4322 [inline]=0A=
>  __schedule+0x911/0x21b0 kernel/sched/core.c:5073=0A=
>  schedule+0xcf/0x270 kernel/sched/core.c:5152=0A=
>  schedule_timeout+0x14a/0x250 kernel/time/timer.c:1892=0A=
>  rcu_gp_fqs_loop kernel/rcu/tree.c:2005 [inline]=0A=
>  rcu_gp_kthread+0xd07/0x2250 kernel/rcu/tree.c:2178=0A=
>  kthread+0x3b1/0x4a0 kernel/kthread.c:292=0A=
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294=0A=
> rcu: Stack dump where RCU GP kthread last ran:=0A=
> Sending NMI from CPU 1 to CPUs 0:=0A=
> NMI backtrace for cpu 0=0A=
> CPU: 0 PID: 3232 Comm: aoe_tx0 Not tainted 5.12.0-rc7-syzkaller #0=0A=
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011=0A=
> RIP: 0010:native_apic_mem_write+0x8/0x10 arch/x86/include/asm/apic.h:110=
=0A=
> Code: c7 40 d9 36 8f e8 c8 11 86 00 eb b0 66 0f 1f 44 00 00 be 01 00 00 0=
0 e9 36 c7 2c 00 cc cc cc cc cc cc 89 ff 89 b7 00 c0 5f ff <c3> 0f 1f 80 00=
 00 00 00 48 b8 00 00 00 00 00 fc ff df 53 89 fb 48=0A=
> RSP: 0018:ffffc90000007ea8 EFLAGS: 00000046=0A=
> RAX: dffffc0000000000 RBX: ffffffff8b0a78c0 RCX: 0000000000000020=0A=
> RDX: 1ffffffff1614f1a RSI: 000000000001c285 RDI: 0000000000000380=0A=
> RBP: ffff8880b9c1f2c0 R08: 000000000000003f R09: 0000000000000000=0A=
> R10: ffffffff8166ecf7 R11: 0000000000000000 R12: 000000000001c285=0A=
> R13: 0000000000000020 R14: ffff8880b9c26340 R15: 0000006120792e26=0A=
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000=
000=0A=
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
> CR2: 00007fb9e6cdb380 CR3: 0000000018792000 CR4: 00000000001506f0=0A=
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=0A=
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400=0A=
> Call Trace:=0A=
>  <IRQ>=0A=
>  apic_write arch/x86/include/asm/apic.h:393 [inline]=0A=
>  lapic_next_event+0x4d/0x80 arch/x86/kernel/apic/apic.c:472=0A=
>  clockevents_program_event+0x254/0x370 kernel/time/clockevents.c:334=0A=
>  tick_program_event+0xac/0x140 kernel/time/tick-oneshot.c:44=0A=
>  hrtimer_interrupt+0x414/0xa00 kernel/time/hrtimer.c:1676=0A=
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]=0A=
>  __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:11=
06=0A=
>  sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100=
=0A=
>  </IRQ>=0A=
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.=
h:632=0A=
> RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]=0A=
> RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]=0A=
> RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:197=0A=
> Code: f0 4d 89 03 e9 f2 fc ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 4=
8 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 40 00 <65> 8b 05 39 fe=
 8d 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b=0A=
> RSP: 0018:ffffc900030cf6f8 EFLAGS: 00000293=0A=
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
> RDX: ffff88801aff1c40 RSI: ffffffff815c2e4f RDI: 0000000000000003=0A=
> RBP: ffffc900030cf738 R08: 0000000000000000 R09: ffffffff8fa9a96f=0A=
> R10: ffffffff815c2e45 R11: 0000000000000000 R12: 000000000000002d=0A=
> R13: ffff8880113db880 R14: 0000000000000000 R15: 0000000000000200=0A=
>  console_trylock_spinning kernel/printk/printk.c:1818 [inline]=0A=
>  vprintk_emit+0x3a5/0x560 kernel/printk/printk.c:2097=0A=
>  dev_vprintk_emit+0x36e/0x3b2 drivers/base/core.c:4434=0A=
>  dev_printk_emit+0xba/0xf1 drivers/base/core.c:4445=0A=
>  __netdev_printk+0x1c6/0x27a net/core/dev.c:11292=0A=
>  netdev_warn+0xd7/0x109 net/core/dev.c:11345=0A=
>  ieee802154_subif_start_xmit.cold+0x17/0x27 net/mac802154/tx.c:125=0A=
>  __netdev_start_xmit include/linux/netdevice.h:4825 [inline]=0A=
>  netdev_start_xmit include/linux/netdevice.h:4839 [inline]=0A=
>  xmit_one net/core/dev.c:3605 [inline]=0A=
>  dev_hard_start_xmit+0x1eb/0x920 net/core/dev.c:3621=0A=
>  sch_direct_xmit+0x2e1/0xbd0 net/sched/sch_generic.c:313=0A=
>  qdisc_restart net/sched/sch_generic.c:376 [inline]=0A=
>  __qdisc_run+0x4ba/0x15f0 net/sched/sch_generic.c:384=0A=
>  qdisc_run include/net/pkt_sched.h:136 [inline]=0A=
>  qdisc_run include/net/pkt_sched.h:128 [inline]=0A=
>  __dev_xmit_skb net/core/dev.c:3807 [inline]=0A=
>  __dev_queue_xmit+0x14b9/0x2e00 net/core/dev.c:4162=0A=
>  tx+0x68/0xb0 drivers/block/aoe/aoenet.c:63=0A=
>  kthread+0x1e7/0x3a0 drivers/block/aoe/aoecmd.c:1230=0A=
>  kthread+0x3b1/0x4a0 kernel/kthread.c:292=0A=
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294=0A=
> NMI backtrace for cpu 1=0A=
> CPU: 1 PID: 37 Comm: kworker/1:1 Not tainted 5.12.0-rc7-syzkaller #0=0A=
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011=0A=
> Workqueue: events nsim_dev_trap_report_work=0A=
> Call Trace:=0A=
>  <IRQ>=0A=
>  __dump_stack lib/dump_stack.c:79 [inline]=0A=
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120=0A=
>  nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105=0A=
>  nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62=0A=
>  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]=0A=
>  rcu_dump_cpu_stacks+0x222/0x2a7 kernel/rcu/tree_stall.h:341=0A=
>  print_cpu_stall kernel/rcu/tree_stall.h:622 [inline]=0A=
>  check_cpu_stall kernel/rcu/tree_stall.h:697 [inline]=0A=
>  rcu_pending kernel/rcu/tree.c:3830 [inline]=0A=
>  rcu_sched_clock_irq.cold+0x4f7/0x11dd kernel/rcu/tree.c:2650=0A=
>  update_process_times+0x16d/0x200 kernel/time/timer.c:1796=0A=
>  tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226=0A=
>  tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1369=0A=
>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]=0A=
>  __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1601=0A=
>  hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663=0A=
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]=0A=
>  __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:11=
06=0A=
>  sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1100=
=0A=
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.=
h:632=0A=
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:1=
61 [inline]=0A=
> RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c=
:191=0A=
> Code: 74 24 10 e8 ba 19 54 f8 48 89 ef e8 f2 cf 54 f8 81 e3 00 02 00 00 7=
5 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> d3 9d 48 f8=
 65 8b 05 7c 68 fc 76 85 c0 74 0a 5b 5d c3 e8 40 59=0A=
> RSP: 0018:ffffc90000dc0b28 EFLAGS: 00000206=0A=
> RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1f5f34a=0A=
> RDX: 0000000000000000 RSI: 0000000000000103 RDI: 0000000000000001=0A=
> RBP: ffff888144fa8000 R08: 0000000000000001 R09: ffffffff8fa9a99f=0A=
> R10: 0000000000000001 R11: ffffc90013880000 R12: ffff888145047440=0A=
> R13: ffff88801ee8e500 R14: dffffc0000000000 R15: ffff888011f69c00=0A=
>  spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]=0A=
>  dummy_timer+0x12f1/0x32a0 drivers/usb/gadget/udc/dummy_hcd.c:1985=0A=
>  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1431=0A=
>  expire_timers kernel/time/timer.c:1476 [inline]=0A=
>  __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1745=0A=
>  __run_timers kernel/time/timer.c:1726 [inline]=0A=
>  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1758=0A=
>  __do_softirq+0x29b/0x9f6 kernel/softirq.c:345=0A=
>  do_softirq.part.0+0xd9/0x130 kernel/softirq.c:248=0A=
>  </IRQ>=0A=
>  do_softirq kernel/softirq.c:240 [inline]=0A=
>  __local_bh_enable_ip+0x102/0x120 kernel/softirq.c:198=0A=
>  spin_unlock_bh include/linux/spinlock.h:399 [inline]=0A=
>  nsim_dev_trap_report drivers/net/netdevsim/dev.c:585 [inline]=0A=
>  nsim_dev_trap_report_work+0x867/0xbd0 drivers/net/netdevsim/dev.c:611=0A=
>  process_one_work+0x98d/0x1600 kernel/workqueue.c:2275=0A=
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2421=0A=
>  kthread+0x3b1/0x4a0 kernel/kthread.c:292=0A=
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 5-1:0.0: unknown status received: -71=0A=
> usbtmc 5-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 5-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 5-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 2-1:0.0: unknown status received: -71=0A=
> usbtmc 4-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: unknown status received: -71=0A=
> usbtmc 3-1:0.0: usb_submit_urb failed: -19=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: unknown status received: -71=0A=
> usbtmc 6-1:0.0: usb_submit_urb failed: -19=0A=
>=0A=
>=0A=
> ---=0A=
> This report is generated by a bot. It may contain errors.=0A=
> See https://goo.gl/tpsmEJ for more information about syzbot.=0A=
> syzbot engineers can be reached at syzkaller@googlegroups.com.=0A=
>=0A=
> syzbot will keep track of this issue. See:=0A=
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.=0A=
>=0A=
> --=0A=
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.=0A=
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.=0A=
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000a9b79905c04e25a0%40google.com.=0A=
