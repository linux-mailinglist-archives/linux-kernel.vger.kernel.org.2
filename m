Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A8404535
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350932AbhIIFxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:53:36 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:9057
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348026AbhIIFxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZDeBhk0EjODt+lALOidARGMN3l+TAmfBN1Mqp71Dwh/9ZD2uUdRJhUH8/+jqUWWrLdilm6DqUDIakxrHpIbXjbtKpWQLmjm/ua6/cKiVsbujXUFdAYB0vdZXwDPO0DJeWR3E5IVhN5bb7UTU94gMI/zOr6fFAlNlTtR3+tOrW4QFyWE+3rpZehpP2LUPEBXNLJgCZn2H4O1hTA80slQNzvkAGjR7PBj3vi0Unn7oe/f5j6pr4uNq6jtIJrc+VPAR92evAd1xoQeAuYM1P7mZ5fzU0SvaWogwn9vZEoCOHT2rwUEfG2447sfqxGhY0zEq7ifXe5n9pRRSphEeJGBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=z79JnB/NAG1J9UgodFjTQCjX1nLPjme7M775zkyj9a0=;
 b=AtEKqlKU6qB5lIAP+yqIaqHom5ZYQwslb9lQtUIcemIBlzEcmVlSBNd4J+fcBZHzXfgha6KlYp3xWIQCGOXEPJq+8U+bv9sOnrl/NJtj58niPKZm79nfBxdtr6DirH81IO9+0jlhAqF1aLVPDVUv4bbjEzbP8wawRXx8sDWG36LChrhV69TjttDgL20zws5P8UzaGEmKXOJ/LKDINzPqx9aGgAOYrBsmDN3APAQ9tlDpAFWfKCirjZ42JDPj5iFD/85dokGwqe2vpDkLNFGJZpa3/VdH1+5g9DT4t7I4Lro5fAelwCjw8j2DJqIXfxPJEex0jbGQZRRjmTL2HgSH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z79JnB/NAG1J9UgodFjTQCjX1nLPjme7M775zkyj9a0=;
 b=GivL3KAypq5ijMQ+/4dPwKGC5EQ3gauBO+p9qjq8rwPrMIOLnc8GxhuWMhjBef/3Qkb/quIA2v4eAzp4GxjVhxPrHE2UlzAIcE/QticKVYEedRREIVkT44zYFuKPUZa8fIH0EhVMNlywr1wmOj1oVverCeS5pc6lRXTkm7wBJnA=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Thu, 9 Sep 2021 05:52:23 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 05:52:23 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6ubJ2WAgAAA8aCAAAnRgIAAAG7g
Date:   Thu, 9 Sep 2021 05:52:23 +0000
Message-ID: <DM6PR12MB4250AE8DF451484884B657C9FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
         <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
         <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <685524a360bc910210cbbb7b13a46ead26ed8a22.camel@perches.com>
In-Reply-To: <685524a360bc910210cbbb7b13a46ead26ed8a22.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-09T05:52:21Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=18db461d-9623-414d-bf80-652b09a01093;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d68a8c9a-82a2-4c93-926c-08d97355ff13
x-ms-traffictypediagnostic: DM5PR12MB2439:
x-microsoft-antispam-prvs: <DM5PR12MB243943FB6E8D186B80715B45FBD59@DM5PR12MB2439.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4mTqMXhU3O91ohnXLiwNI+XxQSxIFFA301jjJAZ5A2AraN1arI+E1bmq7MAHHXCJki7/c8MlFC8PcLD5LaSKXdC4H+w89waaNHku2dFVfJBQuQ8bqnzmcTLDVkPyoZPkLUsKZINcjEsx5JcqDWnWlbzGxFYBjOR08YJU/S+T+4xQruoOMXdlid6pzJO9pZWzUCUgE3qvOMDd96T30GF2nAcfDZzRaAyJZ+pWfRjzYxWhLWG/MED9cu39s8ZFrJEYAFIKPIKU/j0VtP5jBKE+ACvJ+NH98uaEFdtqAj+KrrWkLir32bp/3jVcouph9NkEfChUbiLHXRLC/NtElOj3nByjPg6eAwSEFjSm+E6IdcAeRISLosTtIyLEG3qQUDIaOijKyp/yVFXx6BUYGUXSPShVBSjAFYolvJ5f2DhfL1uAT1GTAlgLuTcZ7QJ3Wo1KPYCGJw6D+AsvkerQlTGDzIOHlhpaTuI0Fq2xaKbi+f0rVTY63sTkmXVa/QhfIffJnrkk4KJFRQ1PbIljaj1tRSAI6jhUQkZ8DhAvztupMtadq5fKVz38tB2n3b7hSBqDqJ43vJD0RCg8jAR+5dbFZx+ugIP3EDWYdSFAVW3rrhsMINGhpIMEMYp1f9qdxHgmn4fY2MgV5nOWbUj3MnTcdej5t+WCJ+6LR8WFWQvO5nwd9WPvahZvnugp3PTzJyjXH61yf96aQ+UVjukK9SfBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(5660300002)(83380400001)(52536014)(2906002)(71200400001)(8936002)(6506007)(55016002)(9686003)(33656002)(110136005)(38100700002)(316002)(26005)(186003)(508600001)(86362001)(64756008)(66556008)(66476007)(66446008)(66946007)(76116006)(7696005)(38070700005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FOQjlzPk5ymF21ZVUfp5EKO5vbUZFC1yrzFi+tCkhavT7noYKQuCeSpqvW2P?=
 =?us-ascii?Q?0wveUdNfNMC762izJIX4i6eT4EWQtaAcrjipRtCZ79Z73R/ineVO2Q5oPlVd?=
 =?us-ascii?Q?6pk9rKEAqE6SKbvBaGKPD0dCpNsP4dMGlTsYhaOLPuuYSBxAFODp5pNF3xZ1?=
 =?us-ascii?Q?RKD3BGZQBKgu7HBqh9Y65xoKy/otRzAiIobNI/Bq9RbLGJ6AvHa6dufd12sk?=
 =?us-ascii?Q?ISNzA13cCRfI9R8i1lNKy38+Bh+aiIiRGGSOA1suNrNwO5tr8ghpsasdNs++?=
 =?us-ascii?Q?iB+dHGEkAHh75yzsKWxL/IUstFMsIBh8k8QSYyxpMzstL0r/MIWdGwxiURcO?=
 =?us-ascii?Q?Z72OST4nyQ53psAzKvVxNoLeOtFvnLXU0qqxy3XlJ1loH5C0j3HqqNHlj89h?=
 =?us-ascii?Q?SXvdr7uZ/OBELmc0VO7NTGdJJmU7SkzOVc4sUqA4GG3kQaXZyu6Dr9yiwoUr?=
 =?us-ascii?Q?69+cx8V7c1sBfKW3c8Tq8qg4aScYlruM5nxV0yNhQcoyDpUCOr6znCqKOfX5?=
 =?us-ascii?Q?zw6FUqfO27PIxRIx8u50zV4rNEZXUfmngWUHcOVfmtiO4EgX5VCNAptrabSv?=
 =?us-ascii?Q?wfTREM0EFf/3bKDicWXm5BvFl9DAWLSiqagszqqN3d79V+eGKL5NvLFF/7Sj?=
 =?us-ascii?Q?1EtJCT0bhZrCMu6DLUUkzzTQmS756/Bt+Vo6KpHP4zFN1Z4R//ETa4tF1zIR?=
 =?us-ascii?Q?chtyuynlRd2H3NxHBBrTcMYLsBgzV6MVsLLrMjzs320uh1by5OvV+3NScx3g?=
 =?us-ascii?Q?azNUlO0xwu7tsZdWX0W3MzOfKJaebHLCyxkXVHHKUrmtRivqvvJv38nkKPhe?=
 =?us-ascii?Q?a+3r2IRnP7wrl6oy0RWCtQmzeQmCSihXtASyl+1cuhqaZG7HX/c4N8Ldp73I?=
 =?us-ascii?Q?jES/Tl0rE/vkIbqVk0o16VQFkNvCvFJXOPfGG7dvX0osC/7eMjJoIRqfGlSR?=
 =?us-ascii?Q?7gu1PYrEt/x7IDcoVxVgw9cWkP22uc1liHlpDriIFg748YrbHlioCB5QyZ/R?=
 =?us-ascii?Q?thAF/WCABLo+SFyplYWyECFIVor8KfO+t3rPTjIL5AbM6OXkXLktmk20e8Nf?=
 =?us-ascii?Q?5elg20nwEmGvkLjUX7mFlOPa8eY9syPNUuDdhOFJttagawekfBI0mAAazTqd?=
 =?us-ascii?Q?ocA59Biv5EHvJ9xs++itywEzGtamfXtAqz1FJqXP0RhHTP6Eth/taO7Fsmbp?=
 =?us-ascii?Q?XaMlIG6nvFpxPhidWBOlrNVQ5ww33QlgD1gyoYMjE3vOdhNtN36ZSu+QEsG4?=
 =?us-ascii?Q?4AKm7CJg/KibADziALUk/ljs6y9j5YqShpH0cTIi2zUjpHRVtBabVI1NFlaS?=
 =?us-ascii?Q?LzxbWO8Go429g7XvHnX4FOGv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68a8c9a-82a2-4c93-926c-08d97355ff13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 05:52:23.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfLHL0xgCpDeLNf9Od6tibC0VQkVA10N/o+fyuC8vJ8H7pRICfTEXZmYjKAm+6S4YvXzXmxckQC7PFxMGXa/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



>-----Original Message-----
>From: Joe Perches <joe@perches.com>
>Sent: Thursday, September 9, 2021 1:44 PM
>To: Yu, Lang <Lang.Yu@amd.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>; linu=
x-
>kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Thu, 2021-09-09 at 05:27 +0000, Yu, Lang wrote:
>> [AMD Official Use Only]
>
>this is a public list and this marker is not appropriate.

Sorry for that.
>
>> > -----Original Message-----
>> > From: Joe Perches <joe@perches.com>
>> > On Wed, 2021-09-08 at 20:07 +0800, Lang Yu wrote:
>> > > The key purpose of sysfs_emit and sysfs_emit_at is to ensure that
>> > > no overrun is done. Make them more equivalent with scnprintf.
>> >
>> > I can't think of a single reason to do this.
>> > sysfs_emit and sysfs_emit_at are specific to sysfs.
>> >
>> > Use of these functions outside of sysfs is not desired or supported.
>> >
>> Thanks for your reply. But I'm still curious why you put such a limitati=
on.
>> As "Documentation/filesystems/sysfs.rst" described, we can just  use
>> scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show functions without
>> such a limitation.
>
>There's nothing particularly wrong with the use of scnprintf as above.
>
>The only real reason that sysfs_emit exists is to be able to reduce the ke=
rnel
>treewide quantity of uses of the sprintf family of functions that need to =
be
>analyzed for possible buffer overruns.
>
>The issue there is that buf is already known to be both a PAGE_SIZE buffer=
 and
>PAGE_SIZE aligned for sysfs show functions so there's no real reason to us=
e
>scnprintf.
>
>sysfs_emit is a shorter/smaller function and using it could avoid some spr=
intf
>defects.
>
>> Some guys just try to replace scnprintf with sysfs_emit() or sysfs_emit_=
at() per
>above documents.
>
>So don't do that.
>
>> But sprintf and sysfs_emit/sysfs_emit_at are not totally equivalent(e.g.=
, page
>boundary align).
>>
>> In my opinion, we add a new api and try to replace an old api. Does we
>> need to make it more compatible with old api?
>
>IMO: no.
>
But why you said " - show() should only use sysfs_emit() or sysfs_emit_at()=
 when formatting
the value to be returned to user space. " in Documentation/filesystems/sysf=
s.rst ?

Obviously, sysfs_emit() and sysfs_emit_at()  can't cover all the cases in s=
how functions.=20

Regards,
Lang

