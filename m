Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA61340056
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCRHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:39:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhCRHjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:39:16 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I7aF5q021867;
        Thu, 18 Mar 2021 00:39:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=r2hi8MnynGmproMdTHuvrbQlKRGhlurggR6BDmRMwYY=;
 b=BKXKUXqg4NqXh6rNTSR+PIQNVOcTQt0DANvIdC7eitsDSUs3D7aRIXjRri4LmqyK2v5B
 jyaGi7+KhyHAkNr88gfYAXshfb4H1Ptha6CBOse08KVzbTrDqgAohOKu/f0BTB6+yzlE
 H8RrbAUrMnbM+TutT7pdvuUjDfj0r53P61Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37bgdhe3us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 00:39:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 00:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krk7IaCUpTXK0Ssku3+hDPWtZqsewIcHEIeHy6pGda1MbTgaqDanCZijBw46noz9jXp3ARsy2eCmVHHZcRUgzR4uQsxiDSaI+361tTZmvgnl1eyvpA5vWxX67scbFayfkCLOC7LwByRjTmYJ+doIKlGdZkFLzRUSl0F9zIu68+Qy/fd+sNZDdjoTOLdww0/jSabmfOBrM/7UNZgwR5iKQYvoZjxU6pEUCyLEvU2ZIS4vNLmM5goyHswCDVt9rEEwFBDF3VYtsUT0JohZjcLBw971DD/ZHUaFej/GXFJosy1lr43z1rxcdr8/VLcBmY7CxdPKeSYTCzAkfotSEkLuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2hi8MnynGmproMdTHuvrbQlKRGhlurggR6BDmRMwYY=;
 b=Xh8Vf3IofkgRyaPH8nsL2E8DoDjqvDoiNWdMJgX+aERy9Nb8pyJI7pVCnoV4A/SVY/64GneUcIaUi7tsCtIKP1MqaP2nWlcbqGng7PYa17Ox9srCwG/+1Bc4Om2854iN8hAn6+eXMnSHoYGKA3gGarrbqGdAygmrng8bAC5yvrMiSJ9Yxq5uZakiU1UxirmXzXZyIy5Mbjstgh3CJ9bb8LEF2ZlPgwZzeub6CebTFB71vgD40htUuUoZtn+QOhI9+EVK85MIDuOkRuXen6w7Rcb5+JlU076aqdjaqUHcpTI08NwSn6nOXirHypNBJW+FhJ+5q8/pNgHJ0NAWal5JQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2773.namprd15.prod.outlook.com (2603:10b6:a03:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 07:39:09 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 07:39:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 3/3] perf-test: add a test for perf-stat --bpf-counters
 option
Thread-Topic: [PATCH v2 3/3] perf-test: add a test for perf-stat
 --bpf-counters option
Thread-Index: AQHXGqn6I/OKoZ/+FEuD284VkHxFJKqJRLeAgAAZgoA=
Date:   Thu, 18 Mar 2021 07:39:08 +0000
Message-ID: <85FE8519-615F-464F-A2BE-06A16D6BAFD0@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-4-songliubraving@fb.com>
 <CAM9d7ciqTGRx6kZ3c-+tXi3AwvOj5EG1ig4oTiUy9sDuTA=KEw@mail.gmail.com>
In-Reply-To: <CAM9d7ciqTGRx6kZ3c-+tXi3AwvOj5EG1ig4oTiUy9sDuTA=KEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:591]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdcb03dd-e0de-41a6-312f-08d8e9e0ea7a
x-ms-traffictypediagnostic: BYAPR15MB2773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB277385E3791035AC09F3E89AB3699@BYAPR15MB2773.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KNTJtf1rVONfqd343Hkpz31fTGYR+fBVTwARenqkEjeXxftghC8vPHEvR3IeVDPT+FcvHVOM3iO8V2ySPNvbSAsiI5bJxyyclYdy/m24V5ye3cIYCaoPeBA31zYSxLHwtDhPOraoKgb4qLCGrzYdci6jJGMVVmQ9DEU4uofcDI34FtEpIifQOMAvq5QyJ6Rr52MmiUqYjpcT2uTsaPvmitxHssqUhbFxcUh8sZgPJMfglvMCJ3YYL9s3zTBtx1ZlxTMx4dqvvCbf4Yfhv86AZ56LKUiKzVe7uEjSa/8huojETqKEf+7fG+plEzVW7gHmOVyhmUuNmXg/KjuXuStos2CjziAFjjWMNueP98tPlxx00ovXFFFOpVFe9i0SQYhUCec161/OR6vwsw4xdoirksEDiXlZSmGQIdb1FCV9CjFWHx8YAX71XDlYyE4d0pH3QMZzANbf6x8iAMNvWe/HWnk/j59flILV5VqF1kS2TgwHc56QDGsfzMl55Gfd6e6tS0HRWH2de4oY/IjGnNM2QRsMgUXf4qi7og79s1ghkEeb56G/tIX5Tq5gUUMaycbjfmxxybtWWRxnhMZHu8X7IFZyRH5Ft0tA8q6Kh659h4DqBOrPeNBd2QIdKgZT5XRdAG4FeZbzx1a1VUh3nu+CAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(66946007)(66556008)(91956017)(71200400001)(2906002)(54906003)(66446008)(64756008)(6486002)(38100700001)(6506007)(6916009)(8936002)(478600001)(8676002)(66476007)(5660300002)(76116006)(53546011)(4326008)(2616005)(6512007)(83380400001)(36756003)(316002)(86362001)(33656002)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KOO8Y6ik0J7auBSAxGLGDbnPxsFpTRwXbngdFakB7rejuzr9NDFjOUcDKoSp?=
 =?us-ascii?Q?l7P5M4esIEShBu9XOGcFdJizEn0B5Y/6WvoA2scAKrMPApkCM9o/G8kx4vxT?=
 =?us-ascii?Q?r4uMJ5u0vkgvMDbeUDHxSrmhsEi70rT4KuQPyIsSetIq+4/a74fzgegFiucI?=
 =?us-ascii?Q?TgndoVPNqwDlr4UoC6Gaf2welrjuN+GOk4QODVJLbiS0aypHalyvwaSYyQY6?=
 =?us-ascii?Q?wXis+ngih2ixFhSyKFMPn3Cm63nfd9W30u58Yphnv3wQA8ftb4iEqPAY/dXf?=
 =?us-ascii?Q?SfMKUoBEF4IuoVk99OlcJYjy4s/EC/1NPzCMM2ABQIxeWNexsbtDZiKOq2ub?=
 =?us-ascii?Q?H2SuvLwo3cRQM3L7gtDDB6y2zCHRBGGMmcpTdSb3TSXNfPRAONwIKm1Uqoy1?=
 =?us-ascii?Q?a/jHWorKb4Rhpott/73mvyhcVOIZkd2ekFKs0bnbA6s4wmvwC7OjwB8aKDtx?=
 =?us-ascii?Q?SalxrvCz7yGIlRAwMRBZKkRttrYtDqIoR0B/jk/V0uH9wKQtdvx53qCfe7TY?=
 =?us-ascii?Q?mxS2vXI8W/biYt15MPSFLuIlTB52XPNBNmeWFP31jZ2KNiOOchjxkQ8HWlKS?=
 =?us-ascii?Q?JV+xK/z1jdSUfW5QZzQM+Ze9PX+L4WC66apoocHmvpy3H5A6DEztVFinjMQM?=
 =?us-ascii?Q?hVKsO65hixrfzgBiDojtjb0hnycfTNnFPctKPttSMGXPYDdmJq4EZgXn/I5J?=
 =?us-ascii?Q?R9hYysykDmnIYSfCu8Y/Zvt/fOIEja7cuHzXvyBc+NSX1VF/4SPZ+u72ktYV?=
 =?us-ascii?Q?L1PodnFo2tTNoZqk5zohljCyZHlMujtMTlCDSmS6jPGiqYFhwscVdhKDV9zE?=
 =?us-ascii?Q?L2aOoEVLA/B40z/3iqFLx+8OskBFE6CHceufhpjDSBli/67aJ5SZDcfPu4Tl?=
 =?us-ascii?Q?FvRLY+JGXa2vgE6h/MWXwRS5TFVg6zZy4ovCdd11PFp5srOFbpCPHIfu3yZc?=
 =?us-ascii?Q?W+59fyuW6v/wjPruylWbGMnAhFklOwWQA9ajj2Ua89XZE8m1b9ndHeJTjgO3?=
 =?us-ascii?Q?umnj1y0YM1U0/lOg4LeDpmIArtVP+BzNywWVM1UWyXm6r7beQ4Fo7oXwaZ2c?=
 =?us-ascii?Q?G+wpRWmgQTSZ4SLAvKJM+SAaZ8inftYc0MlZyuiax1SxFH9DG8+Ar8lfVKhD?=
 =?us-ascii?Q?Cs5//0LxElOcR5OsE6xRbr7O4F/646N7p7l9RuK/oJg3iO/vMMNpFf5jYJ5R?=
 =?us-ascii?Q?YWgyrY1kNfJAVlNMjswMQ92fEMhG8hTRdVZoxYBUtfjzLclif8t8vlHC/bCi?=
 =?us-ascii?Q?L2x9z4McfZynu/veGy4hlw7xAurYOI6w7usksSgfp+9ka+NQKlxvXRZzfsYg?=
 =?us-ascii?Q?qfNxb4hx5gVJwTCrLqJOW0skpGN+uzdEmPy96b4nmsOdEkC3Ke+Uspr+Itkc?=
 =?us-ascii?Q?Idy8JF0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36AEB2D4A7A15F45A1E02E1E17DF779C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcb03dd-e0de-41a6-312f-08d8e9e0ea7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 07:39:08.6539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDgQeDa/boGJAu8onpPK9M0XyGwaC/6Uen0SH0t/ntR0WF/lsEVcJBjEeHWC7CkcmEf8s2LMb0AFxUeautky9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2773
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_02:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180057
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 17, 2021, at 11:07 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>> Add a test to compare the output of perf-stat with and without option
>> --bpf-counters. If the difference is more than 10%, the test is consider=
ed
>> as failed.
>>=20
>> For stable results between two runs (w/ and w/o --bpf-counters), the tes=
t
>> program should: 1) be long enough for better signal-noise-ratio; 2) not
>> depend on the behavior of IO subsystem (for less noise from caching). So
>> far, the best option we found is stressapptest.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/tests/shell/stat_bpf_counters.sh | 34 +++++++++++++++++++++
>> 1 file changed, 34 insertions(+)
>> create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh
>>=20
>> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/te=
sts/shell/stat_bpf_counters.sh
>> new file mode 100755
>> index 0000000000000..c0bcb38d6b53c
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
>> @@ -0,0 +1,34 @@
>> +#!/bin/sh
>> +# perf stat --bpf-counters test
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +set -e
>> +
>> +# check whether $2 is within +/- 10% of $1
>> +compare_number()
>> +{
>> +       first_num=3D$1
>> +       second_num=3D$2
>> +
>> +       # upper bound is first_num * 110%
>> +       upper=3D$(( $first_num + $first_num / 10 ))
>> +       # lower bound is first_num * 90%
>> +       lower=3D$(( $first_num - $first_num / 10 ))
>> +
>> +       if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; the=
n
>> +               echo "The difference between $first_num and $second_num =
are greater than 10%."
>> +               exit 1
>> +       fi
>> +}
>> +
>> +# skip if --bpf-counters is not supported
>> +perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
>> +
>> +# skip if stressapptest is not available
>> +stressapptest -s 1 -M 100 -m 1 > /dev/null 2>&1 || exit 2
>=20
> I don't know how popular it is, but we can print some info
> in case we miss it.

I just realized that perf-bench-sched-messaging is a good test to use,=20
so we don't need stressapptest. Attached the updated version below.

>=20
>> +
>> +base_cycles=3D$(perf stat --no-big-num -e cycles -- stressapptest -s 3 =
-M 100 -m 1 2>&1 | grep -e cycles | awk '{print $1}')
>> +bpf_cycles=3D$(perf stat --no-big-num --bpf-counters -e cycles -- stres=
sapptest -s 3 -M 100 -m 1 2>&1 | grep -e cycles | awk '{print $1}')
>=20
> I think just awk '/cycles/ {print $1}' should work.

Thanks! Fixed in the new version.=20

Song




cat tools/perf/tests/shell/stat_bpf_counters.sh
#!/bin/sh
# perf stat --bpf-counters test
# SPDX-License-Identifier: GPL-2.0

set -e

# check whether $2 is within +/- 10% of $1
compare_number()
{
        first_num=3D$1
        second_num=3D$2

        # upper bound is first_num * 110%
        upper=3D$(( $first_num + $first_num / 10 ))
        # lower bound is first_num * 90%
        lower=3D$(( $first_num - $first_num / 10 ))

        if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
                echo "The difference between $first_num and $second_num are=
 greater than 10%."
                exit 1
        fi
}

# skip if --bpf-counters is not supported
perf stat --bpf-counters true > /dev/null 2>&1 || exit 2

base_cycles=3D$(perf stat --no-big-num -e cycles -- perf bench sched messag=
ing -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
bpf_cycles=3D$(perf stat --no-big-num --bpf-counters -e cycles -- perf benc=
h sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')

compare_number $base_cycles $bpf_cycles
exit 0





