Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6A413700
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhIUQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:10:10 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:62133 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231727AbhIUQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:10:07 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LBnW2i015313;
        Tue, 21 Sep 2021 09:08:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=O3TOG6K1XwJdhplE7ctg2WQs6qMpwmK7E7OHN49R+Rs=;
 b=YLsaixkB6z7lu5KM0koND8r9bMidwXFzcmJrBHnS8agP5pBhRxJ1WHQuJ5KycRPWyJFj
 4YeRKvaQJ8o5onJmKc5zeSB0WUPxND5kMAAoCnfalFsubwxqYngWn2Nq+SWDtElYEpNg
 zONrVujHKYqPdfNEBC4OEA9DlkwnTcd0aNHETbbMuJdgWZ2elirUwyhjJlq6x3jqJhRx
 yyp/lNrNfIeb6PswwfNRwoKjVQcYwSYLLHtg/XDKW25TSnJ12lmOfohP8M591uBDM7yQ
 Dmo9R+b8RVlQem7PzXSz9Na0RZiWAq6MZPXhRrfYVxDfhNS1tOt5CG4WxiiE9UraQWG4 Qw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3b7ev1rjh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 09:08:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWjxE7A1AFOoXM0scE5auBds6HhN6q0rcMEPnWQGen0qCiRxi0LJ6KWkKGtr2czcWhxz5XI8m6nDFTrzzA1AXxL2xPbvdr38Zxc6n7EYGmIZU1dvr1sjbcfnK+KHuLAl7c6Kn1CPf3fgjm+3IENf93BdGme62Vyae+afyFyJdSt97HCKa+hvMtTidj34KBwQpv1oVaSMPF3LD2x/ksuIHSII0Zc9hOkOyPnIvm3JJMA5CvCxamixzD6bACfH1AlarM6ESCbO96KEOHNBq5X6cmRkDsDa06tnkFUaDdtkNS8uv0LKrhbZ9qPZ9tdcMqztA5pCFz649vy4+4JQgP0rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O3TOG6K1XwJdhplE7ctg2WQs6qMpwmK7E7OHN49R+Rs=;
 b=WAeg5ZM5XqwcmJeN13TT98phqCi4llsfVGg/r/A82vB3nY8WD+YmcgEd45tobWzUDE5seMkMZTxbW+DHy90VRuwvcKju4WQQ8r/msbuJJXYoAjIN4ep7l6HWBggcrn5B0qCt2mvJjEDn7mrUIcg6pp5F+/pY+aunnCZ6JrT8EryTo5aZL6CcbB5PgzSTI/VKJ4+f0GwmXwHZVbg3GtjYzXk6BImy6TTmz6xUS4ZCO7YMn8Wqbmi6mMmCswaVZBQVCIJfnt3dqRorUvl1j/wSh1QjKKzNYgYVvuAtk43sbpPZ49M4Z6V9M7WcXVRm3MzKu0vaq9K0zMw+glrCHwEGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB6906.namprd02.prod.outlook.com (2603:10b6:5:257::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.18; Tue, 21 Sep 2021 16:08:29 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e%7]) with mapi id 15.20.4523.019; Tue, 21 Sep 2021
 16:08:29 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "david@redhat.com" <david@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Thread-Topic: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Thread-Index: AQHXrj+D4T8obcdGHUe6vvWc8xL+VautSQuAgADmeYCAAGf/AIAAEdEA
Date:   Tue, 21 Sep 2021 16:08:29 +0000
Message-ID: <C983908F-7AF4-410B-90FF-DB4B9A06E917@nutanix.com>
References: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
 <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
 <YUjb91tWhd/YAgQW@t490s> <F6A49621-C7A4-4643-95C2-F47B02F132D2@nutanix.com>
 <YUn0ikP4Gip3Yc6L@t490s>
In-Reply-To: <YUn0ikP4Gip3Yc6L@t490s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba72d92b-ae2e-4aaf-6b07-08d97d1a0d7b
x-ms-traffictypediagnostic: DM6PR02MB6906:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB6906FCE8DDF09C90A08A6960E6A19@DM6PR02MB6906.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+4J6rQJ7/dTK7z8j+IPXjGStVFSTMCoKlUz6InaAxBUmt1FjL7LvUr/awKU6PIuyElpnb2jpLFAALYNxNWkhYwhlK4F5XfrkOxljQTwEIEcOrCVl+EQhiFPUsYvAxVtBzxhPTTWya08dLzRMg4QO0C/s97BQ/ogmlW5O0Ny1x16UmfWKQ4jepZc8SoEL0ELvUGKJIzhtl3AfRVtdGaMmZvqcDi/RQMQ+tsOyor5Il/AvxyR1n+/4gZdsqm6LYhlSYdLNPh9aMkNp+C4WisizOAQp1shZ8EIuu50zqxClrtocoLBspC6we+Q67Ho3d7mwLDGCAtNF1I+ijmTPmpC0siFKQeFwBq8FbJmMZMD2EJNHXL+aMNGXujiGcrDg0CaXNNzbue2LZ/R+1HmxFPG2FrW1xGSvYoKu71RfBqkawjwDOAyX3ncWsIg5/LfqlS1P1xPXKp3kqVW3PYy7Aa35HOUyuz5wL/6kprP+O45wJPIo67RusxZy8ZJz15VpeRMjcL6lvTwgr3RKHXGcHcLCka07hnnr+ShXoGAKHM5oYBMaKzJnlq9Vpqumvn5telf2HBzOUcE76k+mTm5bAA3R2GBbYV2apLfTE57iDivXom3z70viZloNI4UfIKXt+hm092Jt58hYgLFiTw3RmIW9GcmhzENkxK0PpFWXqDnf75Rpjlt8MmAH89B7yE1Y5l4zYtdIz46SDRaEUIs6kFPrvAp2osSLFqPxF9izKmHHDFYvONINQo6no0SdsANXmNHEutfU4tHRYrkTyf7jlG6C8xmoqwQUfgb+Ri+UnqMHXpFF6Oboq5+LN+10MOTgcfE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(38100700002)(66446008)(8936002)(508600001)(86362001)(6506007)(38070700005)(5660300002)(4326008)(107886003)(316002)(83380400001)(122000001)(53546011)(44832011)(8676002)(66946007)(6916009)(76116006)(6512007)(186003)(33656002)(26005)(91956017)(71200400001)(2906002)(966005)(2616005)(6486002)(66476007)(36756003)(64756008)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EKhDkBOWm2ArfZuHLtGxNEpk8h8QCf1AjSI5y56CYynf7rSW2xlxWtyF8Tkb?=
 =?us-ascii?Q?Y1lAxq95FrOoLBUCkB2GtuMl9VNAUdAekr+7dRRWlMKoDJk9TECbw5LRdt4s?=
 =?us-ascii?Q?O6uWIFccUCtTNswIUDBRCT73F6xFWeVBUfaNsYNfjhai0Lm2lvI647M/pjgR?=
 =?us-ascii?Q?Zhsz6lFzBUYMPp3hYLOB2L/wMy6iTGiIkzSxX/hyF9obRpwNYMeNRHFyVoHw?=
 =?us-ascii?Q?gU7RP10uEayIOua0B95VXsRa/KUAGblBE+1RGq179BNvsHGT4dWBvDaALXCN?=
 =?us-ascii?Q?ayK1Ay4OpKVyaGCyLleImsEAqPe95H4QkPebOC7C8EuoiAgKETdiuGAQJknP?=
 =?us-ascii?Q?xewRhV0M5pVwp61hiMKkU6Mmn3deHuNic1YF9VsS/e6bdxw/+DcuzcMVm5Au?=
 =?us-ascii?Q?m9BV/4fZ76LDlnLF3ilEFalqW0uh9QL1Yo1reN6miestks/T4K4xWWEGnayz?=
 =?us-ascii?Q?PE/QyweuiOBDyVb8jBMEGCJXcq45dlPgrPVcb/6sLnEE4sNLqN+Qg/Dca/L8?=
 =?us-ascii?Q?fXbRTr/KEc8g86qf/1zz1/X7ft86bdBb56sZ6OX5hbDukcppwUVUmED7Wg48?=
 =?us-ascii?Q?oUZq4SNXvyd8PnLCKiFvDOmpU3V/TPmOzvZUSE+6tbryx3GuX9pFZsg/ALBB?=
 =?us-ascii?Q?VQ3+PCp4RR7ltCtoonhUUSkWSHn5AOMdwqjdezHctIRNIwkj2WkIHKVBMUZK?=
 =?us-ascii?Q?6+2R7adPVWnHjznxIs0Xb/b0n9UDRMl/HPoz8YMNLoTHOL+smh8Uc2IvODAr?=
 =?us-ascii?Q?MgjU6tTnWdKcj6OWHZ070c5VSzALyOdjkZMFdNAwZQLvHtH4jwAlyGDlwfgn?=
 =?us-ascii?Q?l6VeBMZ8HyIa6tPFGG8sXm2pFdTBSRgOU6oWEgjDBq9MUDl8yz9qgPWVmYsQ?=
 =?us-ascii?Q?EqbnksEjyvpLk4uLUinbjL+ZR5mz+d3xewax0L0X3zv/miBvRtxIZTvaKdZR?=
 =?us-ascii?Q?MWtBEX5/Pl09k42jQXLmB9noEJ/BkYnJypOkEF7TieA93QskuN+YZaG55plE?=
 =?us-ascii?Q?OzriQi93XvUJUptvgvzm2Pr41qTJM1k7pELHZk5IoG5iG1U8HKpCUwFNLeEQ?=
 =?us-ascii?Q?7h2nUCYr8kC24AnxoiKBgSJGkdFsbOCL4f0JRxYTCKslRXs3SY6Tkxyg+GTc?=
 =?us-ascii?Q?lLutxO05CQK65zO6ZNVe6tOEw2hqPtbtCvVfgqaJ5S2Sqfke1QVH0FGpd3PN?=
 =?us-ascii?Q?Tza/YyTQ5/eKb/RqtJ1g70dE2UfM9GM1rqlyErbps4LX354EgFYTHqrG9/Vr?=
 =?us-ascii?Q?Fd7jOSI7QfdLpgAUEa8p9lheBJYHHKTwxtJFJ/p4OIdJwTZXz5lzTmWgv/jL?=
 =?us-ascii?Q?YZJZwMHVOm9o+uYU1OiczWAk?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C3F40A8DD3AD84FA1709450D1D8DE81@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba72d92b-ae2e-4aaf-6b07-08d97d1a0d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 16:08:29.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jD5s2pcZmNfv17zNTc5Y4fRBp6Gy2E0fy+mYvaRJi01nM5M8PvppQE8jus6N3QNPm6POluMICgFwKz6yeCPvp+F1i38dhBIAHKSd+AE1Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6906
X-Proofpoint-GUID: GZNnUS6pg0WgUCsIoTwpM_ODm2rHguHP
X-Proofpoint-ORIG-GUID: GZNnUS6pg0WgUCsIoTwpM_ODm2rHguHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_04,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Sep 2021, at 16:04, Peter Xu <peterx@redhat.com> wrote:
>=20
> Hi, Tiberiu,
>=20
> On Tue, Sep 21, 2021 at 08:52:32AM +0000, Tiberiu Georgescu wrote:
>> I tested it some more, and it still looks like the mincore() syscall con=
siders pages
>> in the swap cache as "in memory". This is how I tested:
>>=20
>> 1. Create a cgroup with 1M limit_in_bytes, and allow swapping
>> 2. mmap 1024 pages (both shared and private present the same behaviour)
>> 3. write to all pages in order
>> 4. compare mincore output with pagemap output
>>=20
>> This is an example of a usual mincore output in this scenario, shortened=
 for
>> coherency (4x8 instead of 16x64):
>> 00000000
>> 00000000
>> 00001110   <- this bugs me
>> 01111111
>>=20
>> The last 7 bits are definitely marking pages present in memory, but ther=
e are
>> some other bits set a little earlier. When comparing this output with th=
e pagemap,
>> indeed, there are 7 consecutive pages present, and the rest of them are
>> swapped, including those 3 which are marked as present by mincore.
>> At this point, I can only assume the bits in between are on the swap cac=
he.
>>=20
>> If you have another explanation, please share it with me. In the meanwhi=
le,
>> I will rework the doc patch, and see if there is any other way to differ=
entiate
>> clearly between the three types of pages. If not, I guess we'll stick to
>> mincore() and a best-effort 5th step.
>=20
> IIUC it could be because of that the pages are still in swap cache, so
> mincore() will return 1 for them too.

That is my assumption as well.
>=20
> What swap device are you using?  I'm wildly guessing you're not using fro=
ntswap
> like zram.  If that's the case, would you try zram?  That should flush th=
e page
> synchronously iiuc, then all the "suspecious 1s" will go away above.

Correct, I was not using frontswap.
>=20
> To do that, you may need to firstly turn off your current swap:
>=20
>        # swapoff -a
>=20
> Then to configure zram you need:
>=20
>        # modprobe zram
>        # echo 4G > /sys/block/zram0/disksize
>        # mkswap --label zram0 /dev/zram0
>        # swapon --priority 100 /dev/zram0
>=20
> Quotting from here:
>=20
>        https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__wiki.archli=
nux.org_title_Improving-5Fperformance-23zram-5For-5Fzswap&d=3DDwIBaQ&c=3Ds8=
83GpUCOChKOHiocYtGcg&r=3DrRM5dtWOv0DNo5dDxZ2U16jl4WAw6ql5szOKa9cu_RA&m=3DXW=
zLVqSSl8CSEcw2x6sUmspJhiUJei2gq6GTiaky8hk&s=3Dk3BDgO9LN63Nn3vxorlc41MlUYzOU=
N0efajz4lol-k8&e=3D=20
>=20
> Then you can try run the same test program again.

Thanks, it worked!

Hmmm, so if we put emphasis on the accuracy of swap info, or accuracy in
general, we need to use frontswap. Otherwise, mincore() could suffer from
race conditions, and mark pages in the swap cache as being present.

Do you reckon this info (frontswap for mincore) should be present in
the pagemap docs? I wouldn't want to bloat the section either.

Kind regards,
Tibi

