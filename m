Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA803F5105
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhHWTIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:08:41 -0400
Received: from mail-dm6nam12on2132.outbound.protection.outlook.com ([40.107.243.132]:38482
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230192AbhHWTIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:08:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfjjoB7Exeg5L0U1AJfL6HqbQBhtJIpHEedVkiaWH0pyTlJ4YyNhFXAzxNw4aWhqa1TkkE1J8oQgG/ez+LCyYAwK+HcfAimKh3Ow2PYnhmRnt2OKHC3ICfLrXsG2NBn4Uv/hMuZwkhp0GFgNuiEb5A7d/qOwcMrKB4kSmiiYl7aijwOQjGQ4rlGpGFC9P/Kxg3uzcJ4OXKrKQogL7EYGjAkLzQDGLFWe1/jvKTmPFB0IpTzjDW+u/RHjNr6Xa+5rDQTSXPlJpe5rSVMRxABiJh84cY1JqQqF4XN/37ZzDa4RINh8f7+8EDxZZ3hbn3KRaBbHLagz474exjj+MqRCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnka6SM/cbrkwTdZEOgrbq2u0XZQV7R4lGx8qTAj2rE=;
 b=g0YjqCkhcj3ocGBbOZEhroOGxWL4OIn2RekfmHpK5NMjHd4T+2wkNdmf97hS160072zwJwCbJuQpb9PAv4boNr3sOf0BWa4tLEm2RL2envfQY0X3PUVSRVPbYqocfXxHR0xBMB4EeVORswOkLlOWAXCdFremI1lUl9g1s284mabD91+9kWryzaXmpv2LJOC4ty5FB8BXwS77IrESORo11xoOzsQldV+lvru1b8bYvsJKYm4PjxNUmjv+WkjFP0C6rGgEYHM0mRRZKOigrrNEwtOdOz5Hwuv8SCxq7tVcRd6PTEGUPY6C03PNwcnEzpSUsWSdjz7AIjCLqjOSW4u+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnka6SM/cbrkwTdZEOgrbq2u0XZQV7R4lGx8qTAj2rE=;
 b=VQXGZ9ukO842Cm8iGzu4NMKn1Edo37KAC0vLeCRXgSyiDv1zGcWqTyRJ66oF8yyuohVJxb7eDD9dOIgmwLiD2qvEi7R5l9KhDiyr1qyk/g2Q9MO+sJsoojeuXyOnxrsv3Wogkp2Wf1I3RvIa2jU/AU5XcN0oa4CceZnjN9fqB0A=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1861.namprd22.prod.outlook.com (2603:10b6:610:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 19:07:55 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::34a8:735f:a21a:90b7]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::34a8:735f:a21a:90b7%2]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 19:07:55 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     Christoph Hellwig <hch@lst.de>
CC:     "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Thread-Topic: [PATCH] configfs: fix a race in configfs_lookup()
Thread-Index: AQHXlgyibhogppiz1UO3BgTb0yY2XquAueYAgACNQICAAA/SgIAAIUgA
Date:   Mon, 23 Aug 2021 19:07:55 +0000
Message-ID: <6AB8BC39-340D-4F32-881C-8E93A0A8D8C0@purdue.edu>
References: <20210820214458.14087-1-sishuai@purdue.edu>
 <20210823074636.GA23822@lst.de>
 <AFABA8B1-0523-4F8C-A9DD-DDC5638DEAF7@purdue.edu>
 <20210823170847.GA617@lst.de>
In-Reply-To: <20210823170847.GA617@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4591e9e4-9e87-46fb-9762-08d96669503c
x-ms-traffictypediagnostic: CH2PR22MB1861:
x-microsoft-antispam-prvs: <CH2PR22MB1861FF1BADADA5D53B5B36BADFC49@CH2PR22MB1861.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLffKVY/BnQvAAkrECU7QctJqJ6zxlWZvpMUs7FOQxqnaUT0G7Ms8QgrTu8n73l5uwD+mWfjSnG0CjikxE+VRGBkvsvmRb7KI9Ma9DiMhhL79qdoDVD/b+QweXOClBCixxbkGtpa+Q8hEVK3P6zOmmv9K281Fv6mR01EOj1jfsmRfYj2UkYPGc+MaY5OUluoauK3lmYfK5AqWMopDO7OHZyfseDdNOX6uhopynGgzscx4TMGZFjeV0uvwEK0KuSdySVCkoWhdWXKIfO9Baaeo4jdZVfVLPep4hUhGqrAEb1/WWIvmq5ExCOh2izRgW4VFwx0RXHS3SGQYMF2zGl8BLN+vUrJW/fIfyFK+cfL+12ksS37lmdNsx1qT9ABu0OumIc9VSi31K8t9KFM5z24ovFpUJ+uk+SEE1r2YPxA+9UZoYYS70/dYcrop4wMvaY8zpaHpuv72cQ0iBKQYpvbVM9p2IbsVimFGl+Dn5q9NfFRwFhc5TNzNneBDTym56Oz2PeO2zTXPy9oQ4hL2QboaP5AT0/bKWvEU771GntQhrgNpfiToC3AkPSiEYiI2EArs8VdC+hcBVdEv/JweaMBGkWkbD/itD8gqn9KBkUj220tuHlMhC+m3fo+X6EUiwQfGPGTQUwZU3Alv/LZK4YaDZTBQD+Uwey7ww1ebCqaB+oNtgpUgItAS3Ws6+QmmZhPhy7Iotp4Cx1i0smuS6rUlRO+3ukoIO9ez61RRvuyXzI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(366004)(376002)(76116006)(66476007)(71200400001)(83380400001)(66946007)(38070700005)(38100700002)(2906002)(2616005)(316002)(786003)(478600001)(64756008)(66556008)(33656002)(26005)(6512007)(66446008)(122000001)(186003)(6916009)(6506007)(5660300002)(75432002)(8936002)(4326008)(8676002)(53546011)(36756003)(6486002)(86362001)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2cN9wKxDcgHqcEi1RwQlDtYSi3bUieUYaeZpBTDz56PvvkHUxb8H/yeCpHgr?=
 =?us-ascii?Q?suEV3FM7Rjnm0jlmYk3VhcwrQzw3d11M/yP0yFndSIxJ5KqMKSrlLJ6ScS3W?=
 =?us-ascii?Q?vBiNil2yT0g+or685KX3uPGqSp8KKPujeJ1hlabpnu7J7rREVAapxJtIJeZu?=
 =?us-ascii?Q?FxV5lzJvxngjJ92kQJZdMTQjD2Ynapdz6FID3vz31hHfstnYCI/0OGNkpThf?=
 =?us-ascii?Q?gy0yY6rpZxPe+PARbcw8uhCxGPCcaUsPl10aGYzbcWJaEKIZhIWbZOXKEunf?=
 =?us-ascii?Q?q7g/tlNQIMUi82UJtIBROhC9MEK+9LqqTS5+OTO5NJ+mQBDojcOcnTq4K1By?=
 =?us-ascii?Q?A2p0Rntv0JDS3GT7lBVEVH9AFNjills0KwKusyifF+cpY29P9GAyZSJTtMiT?=
 =?us-ascii?Q?znQkpLXJFbvI5oMO3wShwaFNlGRASO5kb4+QPViAPscaz+sSVxqY9K43b3M7?=
 =?us-ascii?Q?zGFiUmDn4YPf4CixmT4QABeX0AgEYn02CvXfksZv3LlyRG9PfDyR6oGZkJSV?=
 =?us-ascii?Q?tiPUzukLXMmoJPf3+ERfEk1p/JRuP0L4dwLB5uzaO5rbqhYi2ojqmz0cTmEE?=
 =?us-ascii?Q?i4YkI4lauSrDVKXzzSyITFRcqu3HZVCXPJ/T7vqhGXI6BjlxGydNkwuPzUVg?=
 =?us-ascii?Q?UJBSE1OlR0Ec3qKITdfhjER6ok1WIFTlpegxq12oswNG90AYC/kxvefyCzI1?=
 =?us-ascii?Q?pjJWroBuiJldyGbXV+xRKGYnq+/wIGyCyrwDPic4eZk2zZWUXtnBK/J14EBD?=
 =?us-ascii?Q?uF1YkHwPZYzZatVMg7pAtGzXaiOZ95tVxY83n0JrnvjNUDxiDbFyQ07jjOx4?=
 =?us-ascii?Q?aSv6/4ZnN/MBSTn5i1rvvtoHo0jaMsLqAslVxbHYkZ21g19vy2pab6L4oN4Z?=
 =?us-ascii?Q?4DkmtK6z90JpIYAdhDsu+iKtqNAQ2nR5qqB+eMm1mLXjEbBPi6E2w8AmS/qh?=
 =?us-ascii?Q?v8AbZ31Og8cwfsgo3CLzZm+XsHTX0qEquSaVG3GRR2qfd8ddmt+WxdQ/A2q0?=
 =?us-ascii?Q?TKcqDZTTkMj3XNWoGjowvS17aK12IXiQHHd8G5CEODrznTUXpau5S63b09da?=
 =?us-ascii?Q?oDOUl50MM6tdyoMsXzcRMUnkXunqWnJ+rh7mKCVyr3iZw5dLp4sWhh4xDkfH?=
 =?us-ascii?Q?RQ1Dy/vzXFy4OQiVmlenigXa9Y/8d/O/63Vjeo4F7C4W9hjsKEfvLj6Op73p?=
 =?us-ascii?Q?rEO/qyFBMAfRs+6wj8baQAbXN8nsQ1PiY4YGXSLn2qTaSkUJ1iSFBeWnmgyW?=
 =?us-ascii?Q?LS7Oag9qFW+Lg40GHrb5B+mdJgV7iq1H7xxBJ4ShDXRKBVeh7Ip9eCuOtSp0?=
 =?us-ascii?Q?x7nypdnGeyR4/euLq3BLL0xs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510C6EAAD16BFE42AEE61912E53D97ED@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4591e9e4-9e87-46fb-9762-08d96669503c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 19:07:55.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXunX3p4ex+7KTFbL5rQvqUimA2FWnekZjbruZo8N8LlWG0FCP02xWRwj/K3aSnQ5nXHneep3QkHBjVWkmFyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1861
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 23, 2021, at 1:08 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Mon, Aug 23, 2021 at 04:12:10PM +0000, Gong, Sishuai wrote:
>> On Aug 23, 2021, at 3:46 AM, Christoph Hellwig <hch@lst.de<mailto:hch@ls=
t.de>> wrote:
>>=20
>> On Fri, Aug 20, 2021 at 05:44:58PM -0400, sishuaigong wrote:
>> When configfs_lookup() is executing list_for_each_entry(),
>> it is possible that configfs_dir_lseek() is calling list_del().
>> Some unfortunate interleavings of them can cause a kernel NULL
>> pointer dereference error
>>=20
>> Thread 1                  Thread 2
>> //configfs_dir_lseek()    //configfs_lookup()
>> list_del(&cursor->s_sibling);
>>                         list_for_each_entry(sd, ...)
>>=20
>> Fix this bug by using list_for_each_entry_safe() instead.
>>=20
>> I don't see how list_for_each_entry_safe would save you there.
>> You need a lock to sychronize the two, list_for_each_entry_safe
>> only ensures the next entry is looked up before iterating over
>> the current one.
>> Thanks for pointing that out!
>>=20
>> It looks like config_lookup() should hold configfs_dirent_lock
>> when doing list_for_each_entry(), but configfs_attach_attr()
>> also needs to be changed since it might be called by
>> config_lookup() and then wait for configfs_dirent_lock,
>> which will cause a deadlock.
>>=20
>> Do you think a future patch like this makes sense?
>=20
> We can't hold a spinlock over inode allocation.  So it would have to be
> something like this:
>=20
Thanks for your suggestion! I will come up with a second patch soon.
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index ac5e0c0e9181..48022e27664d 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -417,44 +417,13 @@ static void configfs_remove_dir(struct config_item =
* item)
> 	dput(dentry);
> }
>=20
> -
> -/* attaches attribute's configfs_dirent to the dentry corresponding to t=
he
> - * attribute file
> - */
> -static int configfs_attach_attr(struct configfs_dirent * sd, struct dent=
ry * dentry)
> -{
> -	struct configfs_attribute * attr =3D sd->s_element;
> -	struct inode *inode;
> -
> -	spin_lock(&configfs_dirent_lock);
> -	dentry->d_fsdata =3D configfs_get(sd);
> -	sd->s_dentry =3D dentry;
> -	spin_unlock(&configfs_dirent_lock);
> -
> -	inode =3D configfs_create(dentry, (attr->ca_mode & S_IALLUGO) | S_IFREG=
);
> -	if (IS_ERR(inode)) {
> -		configfs_put(sd);
> -		return PTR_ERR(inode);
> -	}
> -	if (sd->s_type & CONFIGFS_ITEM_BIN_ATTR) {
> -		inode->i_size =3D 0;
> -		inode->i_fop =3D &configfs_bin_file_operations;
> -	} else {
> -		inode->i_size =3D PAGE_SIZE;
> -		inode->i_fop =3D &configfs_file_operations;
> -	}
> -	d_add(dentry, inode);
> -	return 0;
> -}
> -
> static struct dentry * configfs_lookup(struct inode *dir,
> 				       struct dentry *dentry,
> 				       unsigned int flags)
> {
> -	struct configfs_dirent * parent_sd =3D dentry->d_parent->d_fsdata;
> -	struct configfs_dirent * sd;
> -	int found =3D 0;
> -	int err;
> +	struct configfs_dirent *parent_sd =3D dentry->d_parent->d_fsdata;
> +	struct configfs_dirent *sd;
> +	struct inode *inode =3D NULL;
>=20
> 	/*
> 	 * Fake invisibility if dir belongs to a group/default groups hierarchy
> @@ -464,36 +433,46 @@ static struct dentry * configfs_lookup(struct inode=
 *dir,
> 	 * not complete their initialization, since the dentries of the
> 	 * attributes won't be instantiated.
> 	 */
> -	err =3D -ENOENT;
> 	if (!configfs_dirent_is_ready(parent_sd))
> -		goto out;
> +		return ERR_PTR(-ENOENT);
>=20
> +	spin_lock(&configfs_dirent_lock);
> 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
> -		if (sd->s_type & CONFIGFS_NOT_PINNED) {
> -			const unsigned char * name =3D configfs_get_name(sd);
> +		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
> +		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
> +		    	struct configfs_attribute *attr =3D sd->s_element;
> +			umode_t mode =3D (attr->ca_mode & S_IALLUGO) | S_IFREG;
>=20
> -			if (strcmp(name, dentry->d_name.name))
> -				continue;
> +			dentry->d_fsdata =3D configfs_get(sd);
> +			sd->s_dentry =3D dentry;
> +			spin_unlock(&configfs_dirent_lock);
>=20
> -			found =3D 1;
> -			err =3D configfs_attach_attr(sd, dentry);
> -			break;
> +			inode =3D configfs_create(dentry, mode);
> +			if (IS_ERR(inode)) {
> +				configfs_put(sd);
> +				return ERR_CAST(inode);
This return statement from the original configfs_attach_attr() needs to be =
handled accordingly.
> +			}
> +			if (sd->s_type & CONFIGFS_ITEM_BIN_ATTR) {
> +				inode->i_size =3D 0;
> +				inode->i_fop =3D &configfs_bin_file_operations;
> +			} else {
> +				inode->i_size =3D PAGE_SIZE;
> +				inode->i_fop =3D &configfs_file_operations;
> +			}
> +			goto done;
> 		}
> 	}
> +	spin_unlock(&configfs_dirent_lock);
>=20
> -	if (!found) {
> -		/*
> -		 * If it doesn't exist and it isn't a NOT_PINNED item,
> -		 * it must be negative.
> -		 */
> -		if (dentry->d_name.len > NAME_MAX)
> -			return ERR_PTR(-ENAMETOOLONG);
> -		d_add(dentry, NULL);
> -		return NULL;
> -	}
> -
> -out:
> -	return ERR_PTR(err);
> +	/*
> +	 * If it doesn't exist and it isn't a NOT_PINNED item, it must be
> +	 * negative.
> +	 */
> +	if (dentry->d_name.len > NAME_MAX)
> +		return ERR_PTR(-ENAMETOOLONG);
> +done:
> +	d_add(dentry, inode);
> +	return NULL;
> }
>=20
> /*

